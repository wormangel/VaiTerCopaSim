class CollectionsController < ApplicationController
	before_filter :require_authorization

  def dashboard
  	stickers = Sticker.all()
  	@stickers_json = Hash.new
  	
  	stickers.each do |sticker|
  		@stickers_json[sticker.number] = sticker
  	end
  	
  	@stickers_json = @stickers_json.to_json
  	
  	@dupes = DuplicateSticker.joins(:sticker).where(user: current_user).order('stickers.order')
  	@missing = NeededSticker.joins(:sticker).where(user: current_user).order('stickers.order')
  	
  	@stats = NeededSticker.calculate_stats(current_user)
  	
  end
  
  def add_stickers
  	sticker_numbers = params[:stickers]
  	type = params[:type]
  	user_uid = params[:user]
  	
  	@response = Hash.new
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
  	
  	@response['outcomes'] = @outcomes
  	
  	respond_to do |format|
			format.json  { render json: @response }
		end
  	
  end
  
  def del_stickers
	  sticker_numbers = params[:stickers]
  	type = params[:type]
  	user_uid = params[:user]
  	
  	@response = Hash.new
  	@outcomes = Hash.new
  	
  	case type
  	when "duplicate"
  		m = DuplicateSticker.method(:del_from_collection)
  	when "missing"
  		m = NeededSticker.method(:del_from_collection)
  	end
  	
  	sticker_numbers_a = sticker_numbers.split(",")
  	sticker_numbers_a.each do |s|
  		@outcome = m[s, user_uid]
  		@outcomes[s] = @outcome
  	end
  	
  	@response['outcomes'] = @outcomes
  	
  	respond_to do |format|
			format.json  { render json: @response }
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
	
	def get_stats
		user_uid = params[:user]	
		user = User.find_by uid: user_uid 
	
		@outcome = Hash.new
		
		stats = NeededSticker.calculate_stats(user)
		
		@outcome["stats"] = stats
		
		respond_to do |format|
			format.json  { render json: @outcome }
		end
	end
	
	def compare
		@other_user = User.find_by uid: params[:uid]
		
		@my_dupes = []
		@other_user_dupes = []
		
		current_user_dupes = DuplicateSticker.joins(:sticker).where(user: current_user).order('stickers.order')
		other_user_dupes = DuplicateSticker.joins(:sticker).where(user: @other_user).order('stickers.order')
		current_user_missing = NeededSticker.joins(:sticker).where(user: current_user).order('stickers.order')
		other_user_missing = NeededSticker.joins(:sticker).where(user: @other_user).order('stickers.order')
		
		current_user_dupes.each do |s|
			he_needs = other_user_missing.exists?(stickers: { number: s.sticker.number })
			if (he_needs)
				@my_dupes.append(s)
			end
		end
		
		other_user_dupes.each do |s|
			needed_by_me = current_user_missing.exists?(stickers: { number: s.sticker.number })
			if (needed_by_me)
				@other_user_dupes.append(s)
			end
		end
		
		@other_user_collection_dupes = other_user_dupes
		@other_user_collection_missing = other_user_missing
		
		@stats = NeededSticker.calculate_stats(@other_user)
		
	end
end
