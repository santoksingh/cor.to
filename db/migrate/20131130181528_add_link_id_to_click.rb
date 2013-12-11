class AddLinkIdToClick < ActiveRecord::Migration
  def change
    add_column :clicks, :link_id, :integer
  end
end
