class AddCheckoutFieldsToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :customer_name, :string
    add_column :orders, :address, :text
    add_column :orders, :payment_method, :string
  end
end
