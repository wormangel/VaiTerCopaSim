class AddQtyToNeededStickers < ActiveRecord::Migration
  def change
  	add_column :needed_stickers, :qty, :integer, :default => 0
  end
end
