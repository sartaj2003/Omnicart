class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_many :cart_items

  enum :status, {
    draft: 0,
    active: 1,
    archived: 2
  }

  validates :name, :price_cents, :stock, presence: true


  # ✅ MONEY HELPER
  def price
    price_cents / 100.0
  end


  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "price_cents", "stock", "status", "created_at", "category_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "category" ]
  end
end
