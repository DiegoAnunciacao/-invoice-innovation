class CreateClients < ActiveRecord::Migration[7.2]
  def change
    create_table :clients do |t|
      t.string :client_name
      t.string :client_address
      t.string :client_county
      t.string :client_email
      t.string :client_postcode
      t.string :client_phone

      t.timestamps
    end
  end
end
