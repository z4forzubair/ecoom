class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #Associations
 # has_many :products
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
  validates :first_name, :last_name, :address, :contact_number, :user_role, :flag, :email,  presence: true
  before_create :set_user_flag

  def set_user_flag
    flag = false    #this is not happening!!!
  end

  def admin?
    user_role == 'admin'
  end
  def moderator?
    user_role == 'moderator'
  end
  def buyer?
    user_role == 'buyer'
  end
  def userflag?
    flag == true
  end
end
