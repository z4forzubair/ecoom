class Rating < ApplicationRecord
  belongs_to :user
  #polymorphic for review and product
  belongs_to :rated, polymorphic: true
end
