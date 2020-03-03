class RemoeColumns < ActiveRecord::Migration[5.2]
  def self.up
  remove_column :users, :avatar_content_type
  remove_column :users, :avatar_file_size
  end
end
