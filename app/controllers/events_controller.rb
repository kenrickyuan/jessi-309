class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_dropdown
  def index
    @events = Event.order('start_time')
  end

  def show
    set_event_link if @event.start_time.present?
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    guest1 = Guest.new(name: current_user.name, event: @event)
    guest1.save!

    if @event.save!
      redirect_to event_path(@event)
    else
      render :new
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

  def set_dropdown
  @events = Event.order('start_time')
    @past = []
    @pending = []
    @current = []
    @events.each do |event|
      if event.start_time.nil? || event.start_time > Time.now
        @pending << event
      elsif event.start_time < Time.now || event.end_time < Time.now
        @past << event
      else
        @current << event
      end
    end
    @past
    @pending
    @current
  end

  def set_event_link
    # time is currently in the wrong format but I will change that later
    start_date = CGI.escape(@event.start_time.strftime("%m/%d/%Y %H:%M")) if @event.start_time.present?
    end_date = CGI.escape(@event.end_time.strftime("%m/%d/%Y %H:%M")) if @event.end_time.present?
    title = CGI.escape(@event.title)
    description = CGI.escape(@event.description)
    location = CGI.escape(@event.location)
    # client= key is the api key from addevent.com
    @link_google = "https://www.addevent.com/dir/?client=aheAUbQLvzsrIoghRmUl78304&start=#{start_date}&end=#{end_date}&title=#{title}&description=#{description}&location=#{location}&service=google"
    @link_apple = "https://www.addevent.com/dir/?client=aheAUbQLvzsrIoghRmUl78304&start=#{start_date}&end=#{end_date}&title=#{title}&description=#{description}&location=#{location}&service=apple"
  end
end
