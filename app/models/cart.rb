class Cart < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :quantity, presence: true
end
