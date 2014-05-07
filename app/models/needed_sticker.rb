class NeededSticker < ActiveRecord::Base
  belongs_to :user
  belongs_to :sticker
end
