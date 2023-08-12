class SignupsController < ApplicationController


  def create
      @player = Player.new(
        username: params[:username],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )
    respond_to do |format|
      if @player.save
        format.json { render status: 200, json: @player}
      else
        format.json { render status: 400, json: {message: @player.errors.full_messages}}
      end

    end
  end 

end
