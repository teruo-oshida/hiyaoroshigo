# Original from http://snippets.dzone.com/posts/show/4468 by MichaelBoutros
#
# Optimized version which uses to_yaml for content creation and checks
# that models are ActiveRecord::Base models before trying to fetch
# them from database.

TARGET_MODELS = %w(
  SakeTemperature
  Festival
  Restaurant
  RestaurantParticipation
  Brewery
  Sake
  SakeMenuItem
)

namespace :db do
  namespace :fixtures do
    desc 'Dumps DB records into fixtures.'
    task :dump => :environment do
      models = ENV["MODELS"]&.split || TARGET_MODELS

      puts "Target models: " + models.join(', ')

      models.each do |m|
        model = m.constantize
        next unless model.ancestors.include?(ActiveRecord::Base)

        puts "Dumping model: " + m

        fixture_file = "test/fixtures/#{m.underscore.pluralize}.yml"
        File.open(fixture_file, 'w') do |f|
          model.order('id ASC').each_with_index do |r, i|
            attrs = r.attributes.each_with_object({}) { |(k, v), h|
              if /\A(created_at|updated_at)\z/ !~ k
                h[k] = case v
                when ActiveSupport::TimeWithZone
                  v.to_s
                else
                  v
                end
              end
            }
            f.puts({
              "#{m.underscore}#{i + 1}" => attrs
            }.to_yaml.sub(/\A---\n/, ''))
          end
        end
      end
    end
  end
end
