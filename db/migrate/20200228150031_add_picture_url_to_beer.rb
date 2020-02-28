class AddPictureUrlToBeer < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :picture_url, :string
  end
end
