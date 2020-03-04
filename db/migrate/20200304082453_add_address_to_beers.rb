class AddAddressToBeers < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :address, :string
  end
end
