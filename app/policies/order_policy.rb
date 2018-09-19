class OrderPolicy < ApplicationPolicy
  def user_logged_in?
    !@user.nil?
  end
  def index?
    false
  end
  def create?
    user_logged_in? && @user.flag && (@user.buyer? || @user.moderator?)
  end
  def update?
    false
  end
  def new?
    # true
    user_logged_in? && @user.flag && (@user.buyer? || @user.moderator?)
  end
  def edit?
    false
  end
  def show?
    false
  end
  def destroy?
    false
  end
end
