class EventsController < ApplicationController
  before_action :protect_from_forgery, :authenticate_user!, except: [ :index, :show ]
  def index
    @events = Event.all
  end
end
