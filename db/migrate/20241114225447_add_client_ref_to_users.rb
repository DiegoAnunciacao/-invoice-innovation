class AddClientRefToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :clients, :user, null: true, foreign_key: true
  end
end
