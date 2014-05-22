class NeededSticker < ActiveRecord::Base
  belongs_to :user
  belongs_to :sticker
  
  def self.add_to_collection(sticker_number, user_uid)
  	@outcome = Hash.new
	  @outcome['success'] = true
	  
  	# Fetch the user and sticker
  	user = User.find_by uid: user_uid
  	sticker = Sticker.find_by number: sticker_number
  	
  	# try to find the dupe in db
		needed_in_db = NeededSticker.find_by user: user, sticker: sticker
		if needed_in_db
			#error, you can only need 1 of each sticker (I guess)
			@outcome['success'] = false
			@outcome['message'] = "Figurinha já está na lista de faltantes"
		else
			# create a new needed sticker
			missing = NeededSticker.new(:user => user, :sticker => sticker)
			@outcome['success'] = missing.save
		end
		
		@outcome
  end
  
  def as_json(options)
		super(:include => { :user => {:only => [:uid, :name]}, :sticker => { :only => [:number, :order, :name, :image, :team] }})
	end
	
end
