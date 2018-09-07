class Review < ApplicationRecord
  #self_join
  has_many :comments, class_name: "Review", foreign_key: "comment_id", required: true
  belongs_to :comment, class_name: "Review"
  #with user and product
  belongs_to :product
  belongs_to :user
  #rating
  has_many :ratings, as: :rated
end
