class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  def index
    @events = Event.order('start_time')
  end

  def show
    set_event_link
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path(@event)
    else
      render :new
      set_event_link
    end
  end

  def edit
  end

  def update
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require("event").permit(:start_time, :end_time, :title, :description, :location)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_event_link
    # time is currently in the wrong format but I will change that later
    start_date = CGI.escape(@event.start_time.strftime("%m/%d/%Y"))
    end_date = CGI.escape(@event.end_time.strftime("%m/%d/%Y"))
    title = CGI.escape(@event.title)
    description = CGI.escape(@event.description)
    location = CGI.escape(@event.location)
    # client= key is the api key from addevent.com
    @link_google = "https://www.addevent.com/dir/?client=aheAUbQLvzsrIoghRmUl78304&start=#{start_date}&end=#{end_date}&title=#{title}&description=#{description}&location=#{location}&service=google"
    @link_apple = "https://www.addevent.com/dir/?client=aheAUbQLvzsrIoghRmUl78304&start=#{start_date}&end=#{end_date}&title=#{title}&description=#{description}&location=#{location}&service=apple"
    @link_apple && @link_google
  end
end
