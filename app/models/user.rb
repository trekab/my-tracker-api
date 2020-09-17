class User < ApplicationRecord
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/

  has_secure_password
  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy
end
