class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.references :client, null: true, foreign_key: true
      t.string :notes
      t.integer :vat

      t.timestamps
    end
  end
end
