class AddPriceCentsToOrderItems < ActiveRecord::Migration[8.1]
  def change
    add_column :order_items, :price_cents, :integer
  end
end
