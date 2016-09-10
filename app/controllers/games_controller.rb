class GamesController < ApplicationController 
	def show 
		render template: "games/#{params[:game]}"
	end
end
