class CreateServices < ActiveRecord::Migration[7.2]
  def change
    create_table :services do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :description
      t.integer :amount

      t.timestamps
    end
  end
end
