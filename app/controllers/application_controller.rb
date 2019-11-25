class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_sidebar
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || events_path
  end
  def set_sidebar
  @events = Event.order('start_time')
    @past = []
    @pending = []
    @current = []
    @events.each do |event|
      @past << event if event.end_time < Time.now
      @pending << event if event.start_time > Time.now
      @current << event if (event.start_time <= Time.now) && (event.end_time >= Time.now)
    end
    @past
    @pending
    @current
  end
end
