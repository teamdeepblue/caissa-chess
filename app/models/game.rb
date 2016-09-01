class Game < ActiveRecord::Base 
	has_many :places 
	has_many :players 
end
