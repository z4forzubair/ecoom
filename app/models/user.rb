class User < ApplicationRecord
  has_many :products
  has_many :orders
  #images
  has_many :images, as: :imageable
  #reviews
  has_many :reviews
  #rating
  has_one :rating
end
