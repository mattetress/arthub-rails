class AddUserIdToArtworks < ActiveRecord::Migration[5.2]
  def change
    add_column :artworks, :user_id, :integer
  end
end
