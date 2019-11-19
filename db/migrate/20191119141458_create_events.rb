class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.date :start_time
      t.date :end_time
      t.integer :guest

      t.timestamps
    end
  end
end
