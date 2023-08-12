class LoginsController < ApplicationController

    def create
      player = Player.find_by(username: params[:username])
        respond_to do |format|
        
        if player&.authenticate(params[:password]) #el & sirve para ver si el player esta presente, para no hacer otro if.
          session[:current_player_id] = player.id
          #redirect_to root_url
          format.json {render status: 200, json: {message: "Iniciaste sesion"}}
        else
          format.json{render status: 401, json: {message: "No"}}
            
        end
        end
      end

      def destroy 
        respond_to do |format|
        if session.delete(:current_player_id)
          format.json {render status: 200, json: {message: "Logout exitoso"}}
          @_current_player = nil
        else
          format.json {render status: 400, json: {message: "No se deslogeo"}}
        end
        end
       # redirect_to root_url, status: :see_other
      end


    
end
