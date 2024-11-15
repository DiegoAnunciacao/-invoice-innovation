class AddColumnToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :company_name, :string
    add_column :users, :company_address, :string
    add_column :users, :company_number, :string
    add_column :users, :image_logo, :string
  end
end
