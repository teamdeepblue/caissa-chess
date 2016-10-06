class PlayerController < ApplicationController 
	before_action :authenticate_user! 
	def create 
		@game = Game.find_by_id(params[:game_id]) 
		return render_not_found if @game.blank? 
		existing_player = @game.players.first 
		existing_player.color == :white ? color = :black : color = :white
		@game.players.create(user: current_user, color: color) 
		#redirect_to "whatever page the game is on" 
	end 	

	private 
	def player_params 
		params.require(:player).permit(:name) 
	end 				
end
			