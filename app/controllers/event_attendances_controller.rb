class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])

    unless @event.attendees.include?(current_user)
      @event.attendees << current_user
      flash[:notice] = "You are now attending this event!"
    else
      flash[:notice] = "You are already attending this event."
    end

    redirect_to @event
  end

  def destroy
    attendance = EventAttendance.find(params[:id])
    @event = attendance.attended_event

    if attendance.attendee == current_user
      attendance.destroy
      flash[:notice] = "You are no longer attending this event."
    else
      flash[:notice] = "Unauthorized action."
    end

    redirect_to @event
  end
end
