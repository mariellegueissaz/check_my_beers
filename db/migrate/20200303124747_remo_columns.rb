class RemoColumns < ActiveRecord::Migration[5.2]
  def self.up
  remove_column :users, :avatar_updated_at
  end
end
