class CollectionsController < ApplicationController
  def dashboard
  	stickers = Sticker.all()
  	@stickers_json = Hash.new
  	
  	stickers.each do |sticker|
  		@stickers_json[sticker.number] = sticker
  	end
  	
  	@stickers_json = @stickers_json.to_json
  	
  	@dupes = DuplicateSticker.joins(:sticker).where(user: current_user).order('stickers.order')
  	@missing = NeededSticker.joins(:sticker).where(user: current_user).order('stickers.order')
  	
  end
  
  def add_stickers
  	sticker_numbers = params[:stickers]
  	type = params[:type]
  	user_uid = params[:user]
  	
  	@outcomes = Hash.new
  	
  	case type
  	when "duplicate"
  		m = DuplicateSticker.method(:add_to_collection)
  	when "missing"
  		m = NeededSticker.method(:add_to_collection)
  	end
  	
  	sticker_numbers_a = sticker_numbers.split(",")
  	sticker_numbers_a.each do |s|
  		@outcome = m[s, user_uid]
  		@outcomes[s] = @outcome
  	end
  	
  	respond_to do |format|
			format.json  { render json: @outcomes }
		end
  	
  end
  
  def del_sticker
	  sticker_number = params[:sticker]
  	type = params[:type]
  	user_uid = params[:user]
  	
  	case type
  	when "duplicate"
  		@outcome = DuplicateSticker.del_from_collection(sticker_number, user_uid)
  	when "needed"
  		@outcome = NeededSticker.del_from_collection(sticker_number, user_uid)
  	end
  	
  	respond_to do |format|
			format.json  { render json: @outcome }
		end
  end
  
  def get_stickers
  	type = params[:type]
  	user_uid = params[:user]
  	
  	user = User.find_by uid: user_uid 
  	
  	@outcome = Hash.new
  	
  	case type
  	when "duplicate"
  		stickers = DuplicateSticker.joins(:sticker).where(user: user).order('stickers.order')
  		total = stickers.sum(:qty)
  	when "missing"
  		stickers = NeededSticker.joins(:sticker).where(user: user).order('stickers.order')
  		total = stickers.size
  	end
  	
  	@outcome["stickers"] = stickers
  	@outcome["total"] = total
  	
		
		respond_to do |format|
			format.json  { render json: @outcome }
		end
	end
end
