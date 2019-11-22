class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.references :event, foreign_key: true
      t.string :description
      t.monetize :amount, currency: { present: false }
      t.references :guest, foreign_key: true

      t.timestamps
    end
  end
end
