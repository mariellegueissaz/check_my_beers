require 'csv'

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'beers.csv'

CSV.foreach("beers.csv") do |row|
  Beer.create!{

  }

end
