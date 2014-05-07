class CreateDuplicateStickers < ActiveRecord::Migration
  def change
    create_table :duplicate_stickers do |t|
      t.belongs_to :user, index: true
      t.belongs_to :sticker, index: true

      t.timestamps
    end
  end
end
