class Sticker < ActiveRecord::Base

	def as_json(options)
		super(:only => [:number, :order, :name, :image, :team])
	end
end
