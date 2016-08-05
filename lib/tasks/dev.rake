require 'csv'
namespace :import_incidents_csv do
  task :create_incidents => :environment do
    csv_text = File.read('properties.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Apartment.create!(row.to_hash)
    end
  end
end