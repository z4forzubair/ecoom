class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.boolean :flag
      t.integer :count
      t.decimal :cost
      t.decimal :price
      t.decimal :profit

      t.timestamps
    end
  end
end
