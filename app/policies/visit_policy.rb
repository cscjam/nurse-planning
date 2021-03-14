class VisitPolicy < ApplicationPolicy
  def create?
    return true
  end

  def show?
    return true
  end

  def mark_as_done?
    return true
  end
end
