class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.string :typeform_id
      #_link, display:
      t.string :link
      #title:
      t.string :form_title
      #title:
      t.string :question
      #label:
      t.string :option
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
