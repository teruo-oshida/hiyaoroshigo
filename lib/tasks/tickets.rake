require 'securerandom'
require 'barby/barcode/qr_code'
require 'barby/outputter/png_outputter'
require 'csv'

namespace :tickets do
  desc "Generate tickets"

  task generate: :environment do
    Ticket.transaction do
      if Ticket.count > 0
        STDERR.puts("Do nothing because tickets have already been generated")
        next
      end
      mtq2016 = Festival.find_by(name: "松江トランキーロ2016")
      for name, n in [
        ["そば遊山", 30],
        ["谷屋", 32],
        ["誘酒庵", 38],
        ["老虎", 30],
        ["東風", 20],
        [nil, 50]
      ]
        restaurant = name ? Restaurant.find_by(name: name) : nil
        n.times do
          Ticket.create!(festival: mtq2016,
                         restaurant: restaurant)
        end
      end
      puts("Generated #{Ticket.count} tickets")
    end
  end

  desc "Generate PDFs for tickets"

  task report: :environment do
    Thinreports::Report.generate(filename: 'tickets.pdf',
                                 layout: 'app/reports/tickets') do
      start_new_page

      # QR Code
      page.list(:tickets) do |list|
        Ticket.includes(:restaurant).order("id").each_slice(3) do |tickets|
          list.add_row do |row|
            tickets.each_with_index do |ticket, i|
              n = i.zero? ? "" : "##{i}"
              row.values("url#{n}": "http://bit.ly/mtq16",
                         "restaurant#{n}": ticket.restaurant&.name,
                         "passcode#{n}": ticket.passcode)
              code = Barby::QrCode.new(ticket.signup_url)
              sio = StringIO.new(code.to_png(xdim: 5, ydim: 5))
              row.item("qrcode#{n}").src(sio)
            end
          end
        end
      end
    end
    puts "Generated tickets.pdf"
  end

  desc "Clean tickets"

  task clean: :environment do
    Ticket.delete_all
  end

  namespace :csv do
    desc "Dump CSV for tickets"

    task dump: :environment do
      open("db/tickets.csv", "w") do |f|
        f.puts("id,festival_id,restaurant_id,passcode")
        Ticket.order("id").each do |ticket|
          f.puts([
            ticket.id,
            ticket.festival_id,
            ticket.restaurant_id,
            ticket.passcode
          ].join(","))
        end
      end
      puts "Dumped db/tickets.csv"
    end

    desc "Load CSV for tickets"

    task load: :environment do
      open("db/tickets.csv") do |f|
        Ticket.transaction do
          f.each_line do |line|
            next if /^id,/ =~ line
            id, festival_id, restaurant_id, passcode = line.chomp.split(/,/)
            Ticket.create!(id: id,
                           festival_id: festival_id,
                           restaurant_id: restaurant_id,
                           passcode: passcode)
          end
        end
      end
      puts "Loaded db/tickets.csv"
    end
  end
end
