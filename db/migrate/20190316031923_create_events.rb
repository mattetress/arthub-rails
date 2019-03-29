class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.text :description
      t.boolean :accepting_applications, default: false
      t.integer :user_id

      t.timestamps
    end
  end
end
