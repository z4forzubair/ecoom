class ReviewsBroadcastJob < ApplicationJob
  queue_as :default

  def perform(review)
    # Do something later
    if review.comment_id.nil?
      ActionCable.server.broadcast 'review', review: render_review(review), reply: 'n'
    else
      ActionCable.server.broadcast 'review', review: render_review(review), reply: 'y', comment_id: review.comment_id
    end
  end

  private

  def render_review(review)
    ReviewsController.render(partial: 'reviews/review', locals: { review: review })
    # if review.comment_id.nil?
    #   ReviewsController.render(partial: 'reviews/review', locals: { review: review, reply: reply })
    #   puts('entering this condition' * 50)
    # else
    #   ReviewsController.render(partial: 'reviews/review', locals: { review: review, reply: 'y' })
    # end
  end
end
