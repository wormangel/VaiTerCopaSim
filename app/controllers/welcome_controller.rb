class WelcomeController < ApplicationController
  def index
  	if current_user
  		redirect_to :controller => 'collections', :action => 'dashboard'
  	end
  end
end
