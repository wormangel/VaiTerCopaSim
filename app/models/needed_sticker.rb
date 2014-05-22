class NeededSticker < ActiveRecord::Base
  belongs_to :user
  belongs_to :sticker
  
  def add_to_collection(sticker_number, user_uid)
  	@outcome = Object.new
  	
  	# try to find the needed in db
		needed_in_db = NeededSticker.find_by user: user, sticker: sticker
		if needed_in_db
			# error, you can only need 1 of each sticker (I guess)
			@outcome.success = false
			@outcome.message = "Figurinha já está na lista de faltantes"
		else
			# create a new needed sticker
			missing = NeededSticker.new(:user => user, :sticker => sticker)
			@outcome.success = missing.save
		end
		@outcome
  end
end
