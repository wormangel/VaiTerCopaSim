class CollectionsController < ApplicationController
  def dashboard
  	stickers = Sticker.all()
  	@stickers_json = Hash.new
  	
  	stickers.each do |sticker|
  		@stickers_json[sticker.number] = sticker
  	end
  	
  	@stickers_json = @stickers_json.to_json
  end
end
