class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.integer :event_id
      t.integer :city_id
      t.string :area

      t.timestamps
    end
  end
end
