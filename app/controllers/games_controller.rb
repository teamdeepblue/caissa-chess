class GamesController < ApplicationController 
	def show 
		render template: "games/#{params[:game]}"
	end 

	def new 
		@game = Game.new 
	end 

	def create 
		@game = Game.create 
	end 

	def update 
		@game = Game.find(params[:id]) 
		current_player.update_attribute(:game_id, @game.id) 
	end 
end
