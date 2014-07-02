class SearchController < ApplicationController
  def users
  	@users_data = []

	list = DuplicateSticker.where.not(user: current_user).where(sticker: NeededSticker.select('sticker_id').where(user: current_user)).group(:user).order('count_all DESC').count()

  	list.keys.each do |user|
  		
  		u_data = Hash.new

		u_data["uid"] = user.uid
		u_data["name"] = user.name
		u_data['dupe_count'] = list[user]
		u_data['missing_count'] = 0
		u_data['completed_count'] = 0
		u_data['dupes_I_need_count'] = 0
		u_data['dupes_he_needs_count'] = 0
		
		@users_data.append(u_data)
  	end

  end
end
