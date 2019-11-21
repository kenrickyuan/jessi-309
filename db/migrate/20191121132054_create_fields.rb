class CreateFields < ActiveRecord::Migration[5.2]
  def change
    create_table :fields do |t|
      t.string :title
      t.string :type
      t.references :event, foreign_key: true
      t.references :poll, foreign_key: true
      t.timestamps
    end
  end
end
