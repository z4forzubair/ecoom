class OrderPolicy < ApplicationPolicy
  def user_logged_in?
    !@user.nil?
  end
  def index?
    false
  end
  def create?
    user_logged_in? && @user.userflag? && @user.buyer? || @user.moderator?
  end
  def update?
    false
  end
  def new?
    user_logged_in? && @user.userflag? && @user.buyer? || @user.moderator?
  end
  def edit?
    false
  end
  def destroy?
    false
  end
end
