class ProductOrder < ApplicationRecord
  belongs_to :order, required: true
  belongs_to :product, required: true

  after_save :update_event_status, on: create  #Or after_update :update_event_status

  def update_event_status
      product.update_attributes(quantity: product.quantity - quantity)
  end
  
end
