def change
  # change_column :users, :flag, :boolean, default: true
  def up
    change_table :users do |t|
      t.change :flag, :boolean, default: true
    end
  end

  def down
    change_table :users do |t|
      t.change :flag, :boolean, default: false
    end
  end
end
