class ProductOrder < ApplicationRecord
  belongs_to :orders, required: true
  belongs_to :products, required: true
end
