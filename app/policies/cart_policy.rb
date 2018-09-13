class CartPolicy < ApplicationPolicy
  def index?
    @user.userflag? && @user.buyer? || @user.moderator?
    # true
  end
  def create?
    @user.userflag? && @user.buyer? || @user.moderator?
    # true
  end
  def update?
    @user.userflag? && @user.buyer? || @user.moderator?
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
    @user.userflag? && (@user.buyer? || @user.moderator?)
    # true
  end

end
