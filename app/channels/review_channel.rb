class ReviewChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'review'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
