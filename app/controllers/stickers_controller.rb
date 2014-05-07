class StickersController < ApplicationController
  def index
  	@stickers = Sticker.order(:order)	
  end
end
