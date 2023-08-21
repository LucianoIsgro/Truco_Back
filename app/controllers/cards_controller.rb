class CardsController < ApplicationController


    def index
        respond_to do |format|
        format.json {render status: 200, json: Card.all }
        end
        
    end 

    def create
        @card=Card.create(card_params)
        respond_to do |format|
            if @card.errors.blank?
                format.json {render status: 200, json: @card}
            else
                format.json {render status: 400, json: {message: @card.errors.full_messages}}
            end
        end
        
    end

    def card_params
        params.permit(:numero,:pinta)
    end

end
