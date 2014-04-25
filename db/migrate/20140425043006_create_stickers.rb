class CreateStickers < ActiveRecord::Migration
  def change
    create_table :stickers do |t|
      t.string :number
      t.integer :order
      t.string :name
      t.string :team
      t.string :image

      t.timestamps
    end
  end
end
