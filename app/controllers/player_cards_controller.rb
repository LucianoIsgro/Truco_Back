class PlayerCardsController < ApplicationController
    before_action :set_player_card, only: [:show,:destroy]
    before_action :set_game, only:[:create]
    before_action :set_player, only: [:create,:drop_player_card,:get_player_cards,:dropped]
    before_action :set_card, only: [:drop_player_card]

    def set_game
        @game=Game.find_by(id: params[:game_id])
        return if @game.present?
        respond_to do |format|
            format.json { render status: 400, json: :no_exist }
        end
    end

    def set_player
        @player = Player.find_by(id: session[:current_player_id])
        return if @player.present?
        respond_to do |format|
            format.json {render status: 400, json: :no_exist}
        end
    end

    def set_card
        @card = Card.find_by(id: params[:card_id])
        return if @card.present?
        respond_to do |format|
            format.json {render status: 400 , json: :no_exist}
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
   
    def get_player_cards
        
        player_cards=PlayerCard.where(player_id: @player.id,dropped: false )
        cards = []
        player_cards.each do |card|
            cards.push(Card.find_by(id: card.card_id))
        end
        respond_to do |format|
            format.json {render status: 200, json: cards }
        end
    end
    
    def dropped
        dropped_player_cards=PlayerCard.where(player_id: @player.id,dropped: true )
        ordered=dropped_player_cards.order(:order)
        dropped_cards = []
        ordered.each do |card|
            dropped_cards.push(Card.find_by(id: card.card_id))
        end
        respond_to do |format|
            format.json {render status: 200, json: dropped_cards }
        end
    end



    def drop_player_card
        #@player_card = PlayerCard.find(params[:card_id,:player_id])
        @player_card = PlayerCard.where(card_id: @card.id, player_id: @player.id)

        respond_to do |format|
            if @player_card.update(player_card_params)
                format.json {render status: 200, json: @player_card}
            else
              format.json {render status: 400, json: {message: @player_card.errors.full_messages}}
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
        @player_card.order = 0
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

    def player_card_params
        params.permit(:dropped,:order);
    end


end
