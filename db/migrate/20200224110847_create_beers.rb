class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.string :location
      t.string :name
      t.float :price
      t.string :type
      t.string :photo
      t.text :description
      t.float :degree
      t.string :category
      t.string :barcode

      t.timestamps
    end
  end
end
