class UserPolicy < ApplicationPolicy

  def new?
    @user.admin? || @user.moderator?
  end

  def show?       #how rails/pundit will know that an admin/moderator can do, but a buyer cannot
    @user.admin? || @user.moderator? || @user.buyer? && @user.flag?
  end

  def create?
    @user.admin? || @user.moderator?
  end


end
