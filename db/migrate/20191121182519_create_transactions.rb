class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :expense, foreign_key: true
      t.references :payer, foreign_key: { to_table: :guests }
      t.references :payee, foreign_key: { to_table: :guests }
      t.monetize :amount, currency: { present: false }
      t.boolean :is_debt, default: false

      t.timestamps
    end
  end
end
