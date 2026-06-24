class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])

    if @event.creator != current_user
      redirect_to @event, alert: "ONly the event host can invite guests."
      return
    end

    @user = User.find_by(email: params[:invitation][:email])

    if @user.nil?
      redirect_to @event, alert: "Could not find a user with that email address,"
    elsif @event.invited_users.include?(@user) || @event.creator == @user
      redirect_to @event, alert: "This user is already invited or is the host."
    else
      @event.invited_users << @user
      redirect_to @event, notice: "Successfully invited #{@user.name}!"
    end
  end
end
