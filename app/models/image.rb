class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  #Validations
  validates :image, presence: true
  #validating the presence of foreign_key
  validates :imageable, presence: true
  #max five product images
  validate :max_five_images, on: [ :save ]    #still to put validation that this condition is about products only

  #custom functions
  private
  def max_five_images
    count = Record.count('imageable')
    if count>5
      errors.add('A product cannot have more than five images')
    end
  end
end
