class AddConstraintsToProductsTable < ActiveRecord::Migration[5.2]
  def up
    change_column_null :products, :name, false
    change_column :products, :value, :integer, default: 0
    rename_column :products, :date, :release_date
    add_column :products, :active, :boolean, null: false, default: true
  end

  def down
    change_column_null :products, :name, true
    change_column :products, :value, :integer, default: nil
    rename_column :products, :release_date, :date
    remove_column :products, :active
  end
end
