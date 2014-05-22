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
  
  def self.del_from_collection(sticker_number, user_uid)
  	@outcome = Hash.new
	  @outcome['success'] = true
	  
	  # Fetch the user and sticker
  	user = User.find_by uid: user_uid
  	sticker = Sticker.find_by number: sticker_number
  	
  	# try to find the sticker in db
  	sticker_in_db = NeededSticker.find_by user: user, sticker: sticker
		if sticker_in_db
			# remove it
			@outcome['success'] = sticker_in_db.destroy
		else
			# error
			@outcome['message'] = 'Faltante não encontrada'
			@outcome['success'] = false
		end
		
	  @outcome
  end
  
  def self.calculate_stats(user)
  	@missing = NeededSticker.joins(:sticker).where(user: user).order('stickers.order')
  	
  	@stats = Hash.new
  	@stats['collected'] = 649 - @missing.size
  	@stats['missing'] = @missing.size
  	
  	@stats['teams'] = Hash.new
  	
		teams = ['Especiais', 'Estádios', 'Brasil', 'Croácia', 'México', 'Camarões', 'Espanha', 'Holanda', 'Chile', 
			'Austrália', 'Colômbia', 'Grécia', 'Costa do Marfim', 'Japão', 'Uruguai', 'Costa Rica',
			'Inglaterra', 'Itália', 'Suiça', 'Equador', 'França', 'Honduras', 'Argentina' ,
			'Bósnia Herzegovina', 'Irã', 'Nigéria', 'Alemanha', 'Portugal', 'Gana', 'Estados Unidos',
			'Bélgica', 'Algéria', 'Rússia', 'Coréia', 'Propaganda'
		]
		
		teams.each do |team|
			@stats['teams'][team] = @missing.where(user: user, stickers: { team: team}).size
		end

  	@stats
  end
  
  def as_json(options)
		super(:include => { :user => {:only => [:uid, :name]}, :sticker => { :only => [:number, :order, :name, :image, :team] }})
	end
	
end
