class AddQtyToDuplicateStickers < ActiveRecord::Migration
  def change
  	add_column :duplicate_stickers, :qty, :integer, :default => 0
  end
end
