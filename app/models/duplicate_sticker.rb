class DuplicateSticker < ActiveRecord::Base
  belongs_to :user
  belongs_to :sticker
  
  def self.add_to_collection(sticker_number, user_uid)
	  @outcome = Hash.new
	  @outcome['success'] = true
	  
  	# Fetch the user and sticker
  	user = User.find_by uid: user_uid
  	sticker = Sticker.find_by number: sticker_number
  	
  	# try to find the dupe in db
		dupe_in_db = DuplicateSticker.find_by user: user, sticker: sticker
		if dupe_in_db
			# inc the number of dupes
			dupe_in_db.qty = dupe_in_db.qty + 1
			@outcome['success'] = dupe_in_db.save
		else
			# create a new dupe
			dupe = DuplicateSticker.new(:user => user, :sticker => sticker, :qty => 1)
			@outcome['success'] = dupe.save
		end
		@outcome
  end
  
  def self.del_from_collection(sticker_number, user_uid)
  	@outcome = Hash.new
	  @outcome['success'] = true
	  
	  # Fetch the user and sticker
  	user = User.find_by uid: user_uid
  	sticker = Sticker.find_by number: sticker_number
  	
  	# try to find the sticker in db
  	sticker_in_db = DuplicateSticker.find_by user: user, sticker: sticker
		if sticker_in_db
			# remove it
			if sticker_in_db.qty > 1
				sticker_in_db.qty = sticker_in_db.qty - 1
				@outcome['success'] = sticker_in_db.save
			else
				@outcome['success'] = sticker_in_db.destroy
			end
		else
			# error
			@outcome['message'] = 'Refugo não encontrado'
			@outcome['success'] = false
		end
		
	  @outcome
  end
  
  def as_json(options)
		super(:only => [:qty], :include => { :user => {:only => [:uid, :name]}, :sticker => { :only => [:number, :order, :name, :image, :team] }})
	end
  
end
