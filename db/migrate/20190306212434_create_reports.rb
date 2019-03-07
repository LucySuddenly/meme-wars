class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.text :content
      t.integer :user_id
      t.integer :reportable_id
      t.string :reportable_type

      t.timestamps
    end
  end
end
