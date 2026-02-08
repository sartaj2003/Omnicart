class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  # Total cart price
  def total_price
    cart_items.includes(:product).sum do |item|
      item.product.price_cents * item.quantity
    end / 100.0
  end
end
