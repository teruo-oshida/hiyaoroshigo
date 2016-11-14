require 'securerandom'
require 'barby/barcode/qr_code'
require 'barby/outputter/png_outputter'
require 'csv'

namespace :tickets do
  desc "Generate tickets"

  task generate: :environment do
    unless ENV.key?("COUNT")
      STDERR.puts("Usage: rake tickets:generate COUNT=num [RESTAURANT=name]")
      exit 1
    end
    Ticket.transaction do
      mtq2016 = Festival.find_by(name: "ShimaneCommunities2016")
      if ENV.key?("RESTAURANT")
        restaurant = Restaurant.find_by(name: ENV["RESTAURANT"])
      else
        restaurant = nil
      end
      count = ENV["COUNT"].to_i
      count.times do
        Ticket.create!(festival: mtq2016, restaurant: restaurant)
      end
      puts("Generated #{count} tickets")
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
