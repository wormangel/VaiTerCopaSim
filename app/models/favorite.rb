class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :favorite, :class_name => "User"
  
  def as_json(options)
		super(:include => { :user => {:only => [:uid, :name]}, :favorite => { :only => [:uid, :name] }})
	end
end