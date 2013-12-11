class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :description
      t.string :in_url
      t.string :out_url

      t.timestamps
    end

    add_index :links, :in_url
  end
end
