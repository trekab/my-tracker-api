class Measurement < ApplicationRecord
  validates :total, :user_id, :category_id, presence: true

  belongs_to :user
  belongs_to :category
end
