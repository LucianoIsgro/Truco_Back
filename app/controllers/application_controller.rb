class ApplicationController < ActionController::API
    include ActionController::MimeResponds

    private
    def current_player
        @_current_player ||= session[:current_player_id] &&
          Player.find_by(id: session[:current_player_id])
    end
end
