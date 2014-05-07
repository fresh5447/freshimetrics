class UsersController < ApplicationController
  
  def index
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events
    event = @events.first
    @application_name = event.application
  end
  
end