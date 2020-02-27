require 'csv'

class Beer < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :photo
  csv_options = {col_sep: ';', quote_char: '|', headers: :first_row }
  filepath    = 'app/assets/csv/beers.csv'
  LOCATION = []
  CATEGORIES = []
  MAIN = []
  BREWERY = []
  CSV.foreach(filepath, csv_options) do |row|
  LOCATION << row['manufacturing_places']
  CATEGORIES << row['categories']
  MAIN << row['main_category']
  BREWERY << row['brands']
end
end
