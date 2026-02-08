class AdminUser < ApplicationRecord
  # Devise modules
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable

  # 🔐 Allow ONLY safe attributes for ActiveAdmin search
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "email", "created_at", "updated_at" ]
  end

  # 🔐 Prevent searching on associations unless needed
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
