class SetProductFlagToTrue < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :flag, :boolean, default: true
  end
end
