class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :version
      t.string :author
      t.integer :value
      t.date :date

      t.timestamps
    end
  end
end
