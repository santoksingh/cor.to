class AddFavoriteToLink < ActiveRecord::Migration
  def change
    add_column :links, :favorited, :boolean
  end
end
