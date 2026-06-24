class EventsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :ensure_creator, only: [ :edit, :update, :destroy ]
  def index
    if user_signed_in?
      @upcoming_events = Event.where("date >= ?", Date.today)
                              .where("private = ? OR creator_id = ? OR id IN (?)",
                                    false,
                                    current_user.id,
                                    current_user.invited_event_ids)
                              .order(date: :asc)

      @past_events = Event.where("date < ?", Date.today)
                          .where("private = ? OR creator_id = ? OR id IN (?)",
                                false,
                                current_user.id,
                                current_user.invited_event_ids)
                          .order(date: :desc)
    else
      @upcoming_events = Event.upcoming
      @past_events = Event.past
    end
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
