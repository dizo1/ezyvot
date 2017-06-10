class CreatePageants < ActiveRecord::Migration[5.1]
  def change
    create_table :pageants do |t|
      t.string :name
      t.text :description
      t.string :category
      t.datetime :startdate
      t.datetime :enddate
      t.string :time_zone
      t.string :image

      t.timestamps
    end
  end
end
