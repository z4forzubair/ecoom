class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #Associations
#  has_many :products
  has_many :assigned_by_user, class_name: 'Product', foreign_key: :added_by_user_id
  has_many :deleted_by_user, class_name: 'Product', foreign_key: :deleted_by_user_id
  #orders
  has_many :orders, dependent: :destroy
  #images
  has_many :images, as: :imageable, dependent: :destroy
  #reviews
  has_many :reviews, dependent: :destroy
  #rating
  has_one :rating, dependent: :destroy
  #cart
  has_many :carts, dependent: :destroy

  #Custom Validations

end
