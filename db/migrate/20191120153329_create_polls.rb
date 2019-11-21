class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.string :typeform_id
      #_link, display:
      t.string :link
      #title:
      t.string :form_title
      #field_title:
      t.string :field_title
      #limited to : email, phonenumber, multiple choice
      t.string :field_type
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
