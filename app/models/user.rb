class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable



  has_one  :cart, dependent: :destroy
  has_many :orders, dependent: :destroy


  after_create :create_user_cart

  def create_user_cart
    create_cart!
  end


  def self.ransackable_attributes(auth_object = nil)
    [ "id", "email", "created_at", "updated_at" ]
  end


  def self.ransackable_associations(auth_object = nil)
    []
  end
end
