require 'securerandom'
require 'barby/barcode/qr_code'
require 'barby/outputter/png_outputter'
require 'csv'

namespace :votes do
  desc "Import votes CSV (sake_id, count)"

  task import: :environment do
    open("db/votes.csv") do |f|
      Drinking.where(drinker_id: nil).destroy_all
      Vote.transaction do
        festival = Festival.find_by(name: "松江トランキーロ2016")
        f.each_line do |line|
          next if /^sake_id,/ =~ line
          sake_id, count = line.chomp.split(/,/)
          count.to_i.times do
            Vote.create!(drinking: Drinking.create!(festival: festival,
                                                    sake_id: sake_id),
                         score: 5)
          end
        end
      end
    end
    puts "Imported db/votes.csv"
  end
end
