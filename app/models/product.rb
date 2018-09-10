class Product < ApplicationRecord
#  belongs_to :user, required: true
  belongs_to :assigned_by_user, class_name: 'User', foreign_key: :added_by_user_id
  belongs_to :deleted_by_user, class_name: 'User', foreign_key: :deleted_by_user_id, optional: true
  #product_orders
  has_many :product_orders, dependent: :destroy
  has_many :orders, through: :product_orders
  #images
  has_many :images, as: :imageable, dependent: :destroy
  #reviews
  has_many :reviews, dependent: :destroy
  #rating
  has_many :ratings, as: :rated, dependent: :destroy
  #cart
  has_many :products, dependent: :destroy

  #Validations
  validates :name, :description, :count, :cost, :price, :flag, presence: true
  #foreign_key validation
end
