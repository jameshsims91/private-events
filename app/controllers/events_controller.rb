class EventsController < ApplicationController
  before_action :protect_from_forgery, :authenticate_user!, except: [ :index, :new, :create ]
  def index
    @events = Event.all
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.buld(event_params)

    if @event.save
      redirect_to @event, notice: "Event successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.expect(event: [ :title, :date, :location, :description ])
  end
end
