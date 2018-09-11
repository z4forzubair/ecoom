class AddDescriptionDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :description, :text, default: ''
  end
end
