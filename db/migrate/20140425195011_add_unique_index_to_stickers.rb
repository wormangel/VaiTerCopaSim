class AddUniqueIndexToStickers < ActiveRecord::Migration
  def change
  	
  	add_index :stickers, :number, :unique => true
  	add_index :stickers, :order, :unique => true
  end
end
