class RenameTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :beers, :type, :beer_type
  end
end
