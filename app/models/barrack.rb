class Barrack < ActiveRecord::Base
  belongs_to :camp
  has_many :rooms
end
