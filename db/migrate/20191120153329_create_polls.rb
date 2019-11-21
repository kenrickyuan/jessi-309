class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.string :typeform_id
      t.string :link
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
