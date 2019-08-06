# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? && (user.admin? || user.author?)
  end

  def update?
    user.present? && (user.admin? || (record.author == user))
  end

  def destroy?
    update?
  end
end
