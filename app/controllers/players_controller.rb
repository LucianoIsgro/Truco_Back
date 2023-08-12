class PlayersController < ApplicationController
   
    before_action :set_player, only:[:update,:cards]


    def cards
        respond_to do |format|
            format.json { render status: 200, json: @player.cards}
        end
    end

    def me
        current_player
        respond_to do |format|
            if(@_current_player.present?)
              format.json { render status: 200, json: @_current_player}
            else
              format.json {render status: 400, json: :no_exist}
            end
        end
    end
    

    def index
        respond_to do |format|
            format.json { render status: 200, json: Player.all }
        end
    end

    def show
        respond_to do |format|
            format.json { render status: 200, json: @player }
        end
    end

    

    def update
        respond_to do |format|
            if @player.update(player_params)
                format.json { render status: 200, json: @player}
            else
                format.json { render status: 400, json: {message: @player.errors.full_messages}}
            end
        end
    end


    def destroy
        respond_to do |format|
            if @player.destroy
                format.json { render status: 200, json: @player}
            else
                format.json { render status: 400, json: {message: @player.errors.full_messages}}
            end
        end
    end

    private

    def set_player
       
        @player = Player.find_by(id: params[:player_id])
        
        return if @player.present?
        
        respond_to do |format|
            format.json { render status: 400, json: :no_exist }
        end

    end

    def player_params
        params.permit(:username,:password)
    end
    


end

