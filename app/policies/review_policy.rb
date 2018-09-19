class ReviewPolicy < ApplicationPolicy
  def user_logged_in?
    !@user.nil?
  end
  def index?
    false
  end
  def new?
    false
  end
  def edit?
    false
  end
  def create?
    user_logged_in? && (@user.moderator? || @user.buyer? || @user.admin?)
  end
  def update?
    user_logged_in? && (@user.moderator? || @user.buyer? || @user.admin?)    # to put the validation here that a user can edit only the review that's related to him
  end
  def delete?
    user_logged_in? && (@user.moderator? || @user.buyer? || @user.admin?)
  end
end
