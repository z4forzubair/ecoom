class SetUserFlagToTrue < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :flag, :boolean, default: true
  end
end
