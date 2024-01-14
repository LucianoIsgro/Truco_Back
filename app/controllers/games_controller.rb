class GamesController < ApplicationController

    before_action :set_player, only: [:create]
    before_action :set_cards, only: [:create]
    before_action :set_game, only: [:show,:update,:destroy]

  
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

    def set_cards 
        @cards= Card.all
        if @game.present?
            return if @cards.present?
        else
            return if @cards.present?
        end
        
        respond_to do |format|
            format.json {render status: 401}
        end

    end

    def players
        @game = Game.find_by(id: params[:game_id])
        respond_to do |format|
            if @game.present?
                format.json{render status:200, json: @game.players}
            else
                format.json{render status:400, json: :no_exist}
            end
        end
    end


    def index
        respond_to do |format|
        format.json {render status: 200, json: Game.all }
        end
        
    end

    def show

        respond_to do |format|
        format.json{render status: 200, json: @game}
        end
    
    end

    def create
        @game = Game.new(game_params)
        @game.player = @player
        @game.cards = @cards
        respond_to do |format|
            if @game.save
                #player_game=PlayerGame.new(game_id: @game.id)
                #player_game.player = @player  
                #player_game.save
                format.json {render status: 200, json: @game }
            else
                format.json {render status: 400, json: {message: @game.errors.full_messages}}
            end
        end
    end

    def deal 
      @game = Game.find(params[:game_id])
       
      deck=@game.cards.shuffle


       @game.players.each do |player| 
            
        if(player.cards.length==0)
            player_card = nil
            player_card = PlayerCard.new 
            player_card.player = player
            player_card.card = deck[0]
            deck.delete_at(0)
            player_card.save
            #
            player_card = nil
            player_card = PlayerCard.new 
            player_card.player = player
            player_card.card = deck[0]
            deck.delete_at(0)
            player_card.save
            #       
            player_card = nil
            player_card = PlayerCard.new 
            player_card.player = player
            player_card.card = deck[0]
            deck.delete_at(0)
            player_card.save
            
            return render status:200, json: {message: "Cartas entregadas"}
    
        else
           return render status:400, json: {message: "Ya tiene cartas"}
          #render json: player_card.errors.full_messages  
        end
       end
            
    end

    def update
        respond_to do |format|
          if @game.update(game_params)
            format.json {render status: 200, json: @game}
          else
            format.json {render status: 400, json: {message: @game.errors.full_messages}}
          end
        end
        
    end

    def destroy
    respond_to do |format|
        if @game.destroy
            format.json {render status: 200, json: @game}
        else
          format.json {render status: 400, json: {message: @game.errors.full_messages}}
        end

    end
    end
    
    private

    def set_game
        @game = Game.find_by(id:params[:id])
        return if @game.present?
        respond_to do |format|
            format.json { render status: 400, json: :no_exist }
        end
    end


    def game_params
        params.permit(:nombre,:token,:estado)
    end

   
end
