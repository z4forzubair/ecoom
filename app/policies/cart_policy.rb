class CartPolicy < ApplicationPolicy
  def user_logged_in?
    !@user.nil?
  end

  def index?
    user_logged_in? && @user.flag && (@user.buyer? || @user.moderator?)
    # true
  end

  def create?
    user_logged_in? && @user.flag && (@user.buyer? || @user.moderator?)
    # true
  end

  def update?
    user_logged_in? && @user.flag && (@user.buyer? || @user.moderator?)
    # true
  end

  def show?
    false
    # true
  end

  def new?
    false
    # true
  end

  def edit?
    false
    # true
  end

  def destroy?
    user_logged_in? && @user.flag && (@user.buyer? || @user.moderator?)
    # true
  end
end
