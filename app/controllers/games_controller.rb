<<<<<<< HEAD
class GamesController < ApplicationController 
	def show 
		render template: "games/#{params[:game]}"
	end 

	def update 
		@game = Game.find(params[:id]) 
		current_player.update_attribute(:game_id, @game.id) 
	end 
=======
class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
>>>>>>> master
end
