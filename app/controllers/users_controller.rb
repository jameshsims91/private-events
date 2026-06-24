class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :profile ]

  def profile
    @user = respond_to?(:current_user) ? current_user : User.find_by(id: session[:user_id])
    @user ||= User.first

    if @user.nil?
      render plain: "No users found in the database. Please sign up first." and return
    end

    set_event_variables
    render :show
  end
  def show
    @user = User.find(params[:id])
    set_event_variables
  end

  private

  def set_event_variables
    @created_events = @user.respond_to?(:events) ? @user.events : []
    @upcoming_attended_events = @user.respond_to?(:upcoming_events) ? @user.upcoming_events : []
    @past_attended_events = @user.respond_to?(:past_events) ? @user.past_events : []
  end
end
