class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price_cents
      t.integer :stock
      t.integer :status

      t.timestamps
    end
  end
end
