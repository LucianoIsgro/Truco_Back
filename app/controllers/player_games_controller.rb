class PlayerGamesController < ApplicationController

    before_action :set_player, only: [:create, :delete_player_game]


    def set_player
        @player = Player.find_by(id: session[:current_player_id]) 
     if @game.present?
      return if @player.present? && @game.player.id == @player.id
     else 
        return if @player.present?
     end
     
     respond_to do |format|
        format.json { render status: 401}
      end 
    
    end


    def index
        respond_to do |format|
            format.json {render status: 200, json: PlayerGame.all }
         end
    end

    
    def create
        same_player_game = PlayerGame.find_by(player_id: session[:current_player_id] )
        @player_game = PlayerGame.new(game_id: params[:game_id])
        game=Game.find(params[:game_id])
        @player_game.player = @player 
        respond_to do |format|
          if(same_player_game.present?)
            format.json {render status: 400, json: {message: "Ya estas en un juego"}}
          else
            if (game.estado != 'espera' )
              format.json {render status: 400,json: {message: "El juego ya esta en curso"}}
            else
              if @player_game.save
                format.json { render status: 200, json: @player_game}
              else
                format.json { render status: 400, json: {message: @player_game.errors.full_messages}}
              end
            end
          end

        end   
    end

    def delete_player_game
      @player_game = PlayerGame.find_by(game_id: params[:game_id],player_id: @player.id)
      respond_to do |format|
          if @player_game.destroy
          format.json {render status: 200, json: {message: "Se eliminó el juego"} }
          else
          format.json { render status: 400, json: {message: @player_game.errors.full_messages}}   
          end
        
    
    end
  end



  


end
