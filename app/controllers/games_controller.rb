class GamesController < ApplicationController 

  def index
    @games = Game.joins(:players).group("games.id").having("count(players.id) = ?",1).order(created_at: :desc)
  end

	def show 
		render template: "games/#{params[:game]}"
	end

end
