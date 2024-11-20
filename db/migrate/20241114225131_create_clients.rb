class CreateClients < ActiveRecord::Migration[7.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.string :county
      t.string :email
      t.string :postcode
      t.string :phone

      t.timestamps
    end
  end
end
