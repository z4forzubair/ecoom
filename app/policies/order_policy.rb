class OrderPolicy < ApplicationPolicy
  def index?
    false
  end
  def create?
    @user.userflag? && @user.buyer? || @user.moderator?
  end
  def update?
    false
  end
  def new?
    @user.userflag? && @user.buyer? || @user.moderator?
  end
  def destroy?
    false
  end
end
