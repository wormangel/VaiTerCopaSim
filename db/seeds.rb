def set_team(starting_sticker, ending_sticker, team)	
	Sticker.where(order: (starting_sticker..ending_sticker)).each do |s|
		s.team = team
		s.save
	end
end

def add_normal_stickers(starting_order_number, ending_order_number, order_offset=0)
	(starting_order_number..ending_order_number).each do |i|
		sticker = Sticker.new(:number => i, :order => i + order_offset, :image => i.to_s+".jpg")
		sticker.save
	end
end

# First, special sticker
sticker = Sticker.new(:number => "00", :order => 0, :image => "00.jpg", :team => "Especiais")
sticker.save

# First batch of regularly numbered stickers
add_normal_stickers(1,183)

# Promotional stickers ('happy family' lol), L1 - L4
(184..187).each do |i|
	number = "L" + (4-(187-i)).to_s
	sticker = Sticker.new(:number => number, :order => i, :image => number+".jpg")
	sticker.save
end

# Second batch of regularly numbered stickers
add_normal_stickers(184,335,4)

# Promotional sticker (wise up)
sticker = Sticker.new(:number => "W1", :order => 340, :image => "W1.jpg")
sticker.save

# Third and last batch..
add_normal_stickers(336,639,5)

# Last promotional stickers (Fuleco), J1 - J4
(645..648).each do |i|
	number = "J" + (4-(648-i)).to_s
	sticker = Sticker.new(:number => number, :order => i, :image => number+".jpg")
	sticker.save
end

set_team(1,7,"Especiais")
set_team(8,31,"Estádios")
set_team(32,50,"Brasil")
set_team(51,69,"Croácia")
set_team(70,88,"México")
set_team(89,107,"Camarões")
set_team(108,126,"Espanha")
set_team(127,145,"Holanda")
set_team(146,164,"Chile")
set_team(165,183,"Austrália")

set_team(184,187,"Propaganda")

set_team(188,206,"Colômbia")
set_team(207,225,"Grécia")
set_team(226,244,"Costa do Marfim")
set_team(245,263,"Japão")
set_team(264,282,"Uruguai")
set_team(283,301,"Costa Rica")
set_team(302,320,"Inglaterra")
set_team(321,339,"Itália")

set_team(340,340,"Propaganda")

set_team(341,359,"Suiça")
set_team(360,378,"Equador")
set_team(379,397,"França")
set_team(398,416,"Honduras")
set_team(417,435,"Argentina")
set_team(436,454,"Bósnia Herzegovina")
set_team(455,473,"Irã")
set_team(474,492,"Nigéria")
set_team(493,511,"Alemanha")
set_team(512,530,"Portugal")
set_team(531,549,"Gana")
set_team(550,568,"Estados Unidos")
set_team(569,587,"Bélgica")
set_team(588,606,"Algéria")
set_team(607,625,"Rússia")
set_team(626,644,"Coréia")

set_team(645,648,"Propaganda")