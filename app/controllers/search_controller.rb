class SearchController < ApplicationController
  def users
  	users = User.where.not(uid: current_user.uid)
  	
  	@users_data = []

		current_user_dupes = DuplicateSticker.joins(:sticker).where(user: current_user).order('stickers.order')
		current_user_missing = NeededSticker.joins(:sticker).where(user: current_user).order('stickers.order')

  	users.each do |u|
  		u_data = Hash.new
			u_data["uid"] = u.uid
			u_data["name"] = u.name
		
			user_dupes = DuplicateSticker.joins(:sticker).where(user: u).order('stickers.order')
			u_data['dupe_count'] = user_dupes.size
			
			user_missing = NeededSticker.joins(:sticker).where(user: u).order('stickers.order')
			u_data['missing_count'] = user_missing.size
			u_data['completed_count'] = 649 - user_missing.size

			u_data['dupes_I_need_count'] = 0
			u_data['dupes_he_needs_count'] = 0
			
			current_user_dupes.each do |s|
				he_needs = user_missing.exists?(stickers: { number: s.sticker.number })
				if (he_needs)
					u_data['dupes_he_needs_count'] = u_data['dupes_he_needs_count'] + 1
				end
			end
		
			user_dupes.each do |s|
				needed_by_me = current_user_missing.exists?(stickers: { number: s.sticker.number })
				if (needed_by_me)
					u_data['dupes_I_need_count'] = u_data['dupes_I_need_count'] + 1
				end
			end
			
			@users_data.append(u_data)
  	end
  	
  	@users_data.sort! { |a,b| a["dupes_I_need_count"] <=> b["dupes_I_need_count"] }
  	
  end
end
