class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.string :title
      t.text :description
      t.datetime :date

      t.timestamps
    end
  end
end
