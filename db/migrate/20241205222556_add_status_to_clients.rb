class AddStatusToClients < ActiveRecord::Migration[7.2]
  def change
    add_column :clients, :status, :boolean, default: true
  end
end
