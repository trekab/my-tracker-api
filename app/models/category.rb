class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  belongs_to :user
  has_many :measurements, dependent: :destroy
end
