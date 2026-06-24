class EventsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :ensure_creator, only: [ :edit, :update, :destroy ]
  def index
    @upcoming_events = Event.upcoming
    @past_events = Event.past
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event, notice: "Event successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

    def destroy
      @event.destroy
      redirect_to root_path, notice: "event was scuccessfully deleted.", status: :see_other
    end

  private

  def event_params
    params.expect(event: [ :title, :date, :description, :private ])
  end

  def ensure_creator
    @event = Event.find(params[:id])
    unless @event.creator == current_user
      redirect_to root_path, alert: "You are not authorized to modify this event."
    end
  end
end
