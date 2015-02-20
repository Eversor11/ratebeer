class AddFroznToUser < ActiveRecord::Migration
  def change
    add_column :users, :frozn, :boolean
  end
end
