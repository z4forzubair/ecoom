class Product < ApplicationRecord
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
  has_many :carts, dependent: :destroy

  #Validations
  before_validation :checkQuantity, on: [:create, :update, :save] # to make it after validation
  # before_validation :set_delete_by_user, on: [:destroy]
  validates :name, :quantity, :cost, :price, :discount, presence: true

  validates :flag, inclusion: { in: [true, false] }   # to make this too after validation and function call
  validates :flag, exclusion: { in: [nil] }   # to make this too after validation and function call


  def productflag?
    self.flag == true
  end

  private

  def checkQuantity
    if quantity == 0
      self.flag = false
    else
      self.flag = true
    end
    puts 'entered flag function', self.flag
  end
  # def set_assigned_by_user
  #   self.added_by_user_id=current_user.id
  # end
  # def set_delete_by_user
  #   self.delete_by_user_id=current_user.id
  # end
end
