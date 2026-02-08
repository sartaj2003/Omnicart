class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  # ✅ convert cents to rupees
  def unit_price
    price_cents / 100.0
  end

  def total_price
    (price_cents * quantity) / 100.0
  end
end
