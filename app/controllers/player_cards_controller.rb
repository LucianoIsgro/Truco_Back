class PlayerCardsController < ApplicationController
    before_action :set_player_card, only: [:show,:destroy]
    before_action :set_game, only:[:create]
    before_action :set_player, only: [:create]

    def set_game
        @game=Game.find_by(id: params[:game_id])
        return if @game.present?
        respond_to do |format|
            format.json { render status: 400, json: :no_exist }
        end
    end

    def set_player
        @player=Player.find_by(id: params[:id])
        return @player.present?
        respond_to do |format|
            format.json {render status: 400, json: :no_exitst}
        end
    end


    def delete_player_card
        @player_card = PlayerCard.find_by(card_id: params[:card_id])
       
        respond_to do |format|
            if @player_card.destroy
            format.json {render status: 200, json: {message: "Se eliminó"} }
            else
            format.json { render status: 400, json: {message: @player_card.errors.full_messages}}   
            end
        end

       
    end

    def index
        respond_to do |format|
            format.json {render status: 200, json: PlayerCard.all }
        end
    end
    
    def show
        respond_to do |format|
            format.json {render status:200, json: @player_card}
        end
    end


    def create
        @deck=@game.cards.shuffle
        @player_card = PlayerCard.new()
        @player_card.card = @deck[0]
        @deck.delete_at(0)
        @player_card.player = @player
       
        respond_to do |format|
            if (@player.cards.length < 3)
              if @player_card.save
                  format.json {render status: 200, json: @player_card.card }
              else
                  format.json {render status: 400, json: {message: @player_card.errors.full_messages}}
              end
            else
                format.json {render status: 400, json: {message: "Ya tiene cartas"}}
            end
        end
    end

    def destroy
        respond_to do |format|
            if @player_card.destroy
                format.json { render status: 200, json: @player_card}
            else
                format.json { render status: 400, json: {message: @player_card.errors.full_messages}}
            end
        end
    end

    private
    def set_player_card
        @player_card = PlayerCard.find_by(id: params[:id])
       
        return if @player_card.present?
        
        respond_to do |format|
            format.json { render status: 400, json: :no_exist }
        end

    end


end
