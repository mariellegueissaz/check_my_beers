class AddBreweryToBeers < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :brewery, :string
  end
end
