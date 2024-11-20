class InvoicePolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def index?
    true
  end

  def show?
    user_client = Client.where(id: record.client_id, user_id: user.id)
    user_client.present?
  end

  def create?
    true
  end

  def new?
    true
  end

  def edit?
    user_client = Client.where(id: record.client_id, user_id: user.id)
    user_client.present?
  end

  def update?
    user_client = Client.where(id: record.client_id, user_id: user.id)
    user_client.present?
  end

  def destroy?
    user_client = Client.where(id: record.client_id, user_id: user.id)
    user_client.present?
  end

  private

  def user_owns_record?
    record.user_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
