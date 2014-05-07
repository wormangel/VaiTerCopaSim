class AddDuplicateStickers < ActiveRecord::Migration
  def change
  	create_table :duplicate_stickers do |t|
      t.belongs_to :user
      t.belongs_to :sticker

      t.timestamps
    end
  end
end
