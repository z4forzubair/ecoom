class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  # Validations
  validates :image, presence: true
  # validating the presence of foreign_key
  validates :imageable, presence: true
  # max five product images
  before_validation :max_count, on: %i[create update save]
  # mount image uploader
  mount_uploader :image, ImageUploader

  # custom functions

  private

  def max_count
    if imageable_type == 'User'
      count_user
    elsif imageable_type == 'Product'
      count_product
    end
  end

  # count Users
  def count_user
    imageId = Image.where(imageable_id: imageable_id).count
    if imageId >= 1
      errors.add('UserImages', 'A User has only one profile picture')
    end
  end

  # count Products
  def count_product
    # imageId2 = Image.group(:imageable_id).count
    imageId = Image.where(imageable_id: imageable_id).count
    if imageId >= 5
      errors.add('ProdcutImages', 'A product cannot have more than five images')
    end
  end
end
