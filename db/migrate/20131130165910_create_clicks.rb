class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.string :ip
      t.string :browser
      t.string :country
      t.string :referer

      t.timestamps
    end
  end
end
