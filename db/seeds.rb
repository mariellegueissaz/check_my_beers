require 'csv'
require 'open-uri'

puts "Delete Database..."

Review.destroy_all
Beer.destroy_all
User.destroy_all

puts "Create User..."

arthur = User.create!(
  email: "arthurrr@gmail.com",
  password: "arthurrr"
  )

csv_options = {col_sep: ';', quote_char: '|', headers: :first_row }
filepath    = 'app/assets/csv/beers.csv'

puts "Create Beers..."

CSV.foreach(filepath, csv_options) do |row|

b = Beer.create!(
    name: row['product_name'],
    location: row['manufacturing_places'],
    beer_type: row['categories'],
    degree: row['alcohol_100g'],
    category: row['main_category'],
    barcode: row['code'],
    brewery: row['brands'],
    description: row['main'],
    picture_url: row['image_front_url']
    )
end

puts "Done!"
