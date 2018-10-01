class CartPolicy < ApplicationPolicy
  def user_logged_in?
    !@user.nil?
  end

  def index?
    user_logged_in? && @user.flag && (@user.buyer? || @user.moderator?)
  end

  def create?
    user_logged_in? && @user.flag && (@user.buyer? || @user.moderator?)
  end

  def update?
    user_logged_in? && @user.flag && (@user.buyer? || @user.moderator?)
  end

  def show?
    false
  end

  def new?
    false
  end

  def edit?
    false
  end

  def destroy?
    user_logged_in? && @user.flag && (@user.buyer? || @user.moderator?)
  end
end
