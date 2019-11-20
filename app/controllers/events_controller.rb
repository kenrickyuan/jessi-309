class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  def index
    @events = Event.order('start_time')
  end

  def show
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
    redirect_to spaces_path
  end

  private

  def event_params
    params.require("event").permit(:start_time, :end_time, :title, :guests, :location)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
