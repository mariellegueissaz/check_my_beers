require 'csv'

class Beer < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  csv_options = {col_sep: ';', quote_char: '|', headers: :first_row }
  filepath    = 'app/assets/csv/beers.csv'
  LOCATION = []
  CATEGORIES = []
  MAIN = []
  BREWERY = []
  CSV.foreach(filepath, csv_options) do |row|
    LOCATION << row['manufacturing_places'] unless row['manufacturing_places'].nil?
    CATEGORIES << row['categories'] unless row['categories'].nil?
    MAIN << row['main_category'] unless row['main_category'].nil?
    BREWERY << row['brands'] unless row['brands'].nil?
  end
end
