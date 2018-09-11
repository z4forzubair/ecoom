class ReviewPolicy < ApplicationPolicy
  def create?
    @user.moderator? || @user.buyer?
  end
  def update?
    @user.moderator? || @user.buyer?    # to put the validation here that a user can edit only the review that's related to him
  end
  def delete?
    @user.moderator? || @user.buyer?
  end
end
