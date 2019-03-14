class AddUrlToArtworks < ActiveRecord::Migration[5.2]
  def change
    add_column :artworks, :url, :string
  end
end
