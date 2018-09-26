class Review < ApplicationRecord
  after_create_commit { ReviewsBroadcastJob.perform_now(self) }
  # self_join
  has_many :comments, class_name: 'Review', foreign_key: 'comment_id'
  belongs_to :comment, class_name: 'Review', optional: true
  # with user and product
  belongs_to :product
  belongs_to :user
  # rating
  has_many :ratings, as: :rated

  validates :revcontent, presence: true

  # Validations
  before_validation :one_level_nesting, on: %i[create update save]

  private

  def one_level_nesting
    prev_foreign_key = Review.where(id: comment_id).pluck(:comment_id)
    unless prev_foreign_key[0].nil?
      errors.add('SelfReview', 'You cannot reply to this comment')
    end
  end
end
