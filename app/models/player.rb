class Player < ActiveRecord::Base 
	belongs_to :account 
	belongs_to :game 
end
