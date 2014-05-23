class FavoritesController < ApplicationController

	def create
		uid = params[:uid]
		
		@response = Hash.new
		
		user = User.find_by uid: uid
		
		# is it already a favorite?
		already = user.is_favorite_of(current_user)
		
		if already
			@response['success'] = false
			@response['message'] = 'Usuário já favoritado'
		else
			fav = Favorite.new(:user => current_user, :favorite => user)
			@response['success'] = fav.save
		end
  	
  	respond_to do |format|
			format.json  { render json: @response }
		end
	end
	
	def destroy
		uid = params[:uid]
		
		@response = Hash.new
		
		user = User.find_by uid: uid
		
		# is it already a favorite?
		already = user.is_favorite_of(current_user)
		
		if not already
			@response['success'] = false
			@response['message'] = 'Usuário não é favoritado'
		else
			fav = Favorite.find_by user: current_user, favorite: user
			@response['success'] = fav.destroy
		end
  	
  	respond_to do |format|
			format.json  { render json: @response }
		end
	end
	
	def get_favs  	
  	@outcome = Hash.new
  	@outcome["favs"] = current_user.favorites
  	
		respond_to do |format|
			format.json  { render json: @outcome }
		end
	end
	
end
