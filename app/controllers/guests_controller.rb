class GuestsController < ApplicationController
  before_action :set_guest, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:new, :create, :edit, :update]
  def index
    @guests = Guest.all
  end

  def show
  end

  def new
    @guest = Guest.new
  end

  def create
    guests = params[:guests]
    guests.each_with_index do |guest, i|
      c = guest.size
      @guest = Guest.new(name: guest, event: @event)
      if i != (c - 1)
        @guest.save
      else
        if @guest.save
          redirect_to event_path(@event, @guest)
        else
          render "events/show"
        end
      end
    end
  end

  def edit
    @guest.event = @event
  end

  def update
    @guest.update(guest_params)
    redirect_to event_guests_path(@event, @guest)
  end

  def destroy
    @guest.destroy
    @event = Event.find(params[:event_id])
    redirect_to event_path(@event)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_guest
    @guest = Guest.find(params[:id])
  end

  def guest_params
    params.require("guest").permit(:name)
  end
end
