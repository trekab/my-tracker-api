# frozen_string_literal: true

class Measurement < ApplicationRecord
  validates :product_id, :category_id, presence: true
  belongs_to :product
  belongs_to :category
end
