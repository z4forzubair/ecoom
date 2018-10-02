class Product < ApplicationRecord
  # for user stamps
  audited
  # product_orders
  has_many :product_orders, dependent: :destroy
  has_many :orders, through: :product_orders
  # images
  has_many :images, as: :imageable, dependent: :destroy
  # reviews
  has_many :reviews, dependent: :destroy
  # rating
  has_many :ratings, as: :rated, dependent: :destroy
  # cart
  has_many :carts, dependent: :destroy

  # Validations
  before_validation :checkQuantity, on: %i[create update save] # to make it after validation
  # before_validation :set_delete_by_user, on: [:destroy]
  validates :name, :quantity, :cost, :price, :discount, presence: true

  validates :flag, inclusion: { in: [true, false] } # to make this too after validation and function call
  validates :flag, exclusion: { in: [nil] } # to make this too after validation and function call

  scope :flagged, -> { where(flag: true) }
  scope :unflagged, -> { where(flag: false) }
  def flagged?
    flag == true
  end

  private

  def checkQuantity
    self.flag = quantity != 0
  end
  # def set_assigned_by_user
  #   self.added_by_user_id=current_user.id
  # end
  # def set_delete_by_user
  #   self.delete_by_user_id=current_user.id
  # end
end
