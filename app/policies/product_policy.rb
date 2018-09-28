class ProductPolicy < ApplicationPolicy
  def initialize(user, product)
    @user = user
    @product = product
  end

  def user_logged_in?
    !@user.nil?
  end

  def index?
    true
  end

  def new?
    user_logged_in? && @user.flag && (@user.admin? || @user.moderator?)
  end

  def show?
    # (@product.flag)
    @product.flag || (user_logged_in? && @user.flag && (@user.admin? || @user.moderator?))
    # authorization need in case the show view
  end

  def edit?
    # binding.pry
    user_logged_in? && @user.flag && (@user.admin? || @user.moderator?) # Any moderator can edit
  end

  def create?
    # true
    user_logged_in? && @user.flag && (@user.admin? || @user.moderator?)
  end

  def update?
    user_logged_in? && @user.flag && (@user.admin? || @user.moderator?) # Any moderator can update
  end

  def destroy?
    user_logged_in? && @user.flag && (@user.admin? || @user.moderator?)
  end
end
