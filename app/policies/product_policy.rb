class ProductPolicy < ApplicationPolicy

  def initialize(user, product)
    @user = user
    @product = product
  end

  def index?
    true
  end
  def new?
    @user.userflag? && @user.admin? || @user.moderator?
  end

  def show?
    @product.productflag?
    # authorization need in case the show view
  end

  def edit?
    @product.productflag? && @user.userflag? && @user.admin? || @user.moderator? # Any moderator can edit
  end

  def create?
    # true
    @user.userflag? && @user.admin? || @user.moderator?
  end

  def update?
    @product.productflag? && @user.userflag? && @user.admin? || @user.moderator? # Any moderator can update
  end

  def destroy?
    @product.productflag? && @user.userflag? && @user.admin? || @user.moderator?
  end


end
