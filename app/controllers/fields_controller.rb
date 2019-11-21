class FieldsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @field = Field.new
    @poll = Poll.find(params[:poll_id])
    @event = Event.find(params[:event_id])
  end

  def create
    @field = Field.new(field_params)
    @poll = Poll.find(params[:poll_id])
    @event = Event.find(params[:event_id])
    @field.poll = @poll
    template = {"label" : }
    array_choices = []
    # body = {
    #   "title": "#{@poll.form_title}",
    #   "fields": [ {
    #   "title": "#{@field.title}",
    #   "type": "multiple choice"
    #   }, {
    #   "title": "And your Phonenumber?",
    #   "type": "phone_number"}
    #   ]
    # }
   body = {
  "title": "Multiple Choice",
  "fields": [ {
  "title": "Choose:",
  "type": "multiple_choice",
  "properties": {
    "description": "Which location/s do you prefer?",
    "allow_multiple_selection": true,
    "allow_other_choice": true,
    "choices": array_choices
    }
  }
  ]
}

    typeform_api = Typeform.new
    response = typeform_api.create_form(body)
    @poll.link = response.parsed_response["_links"]["display"]

 respond_to do |format|
  if @field.save!

    format.html { redirect_to event_poll_path(@event, @poll), notice: 'Question was successfully created.' }
  else
    format.html { render :new }
  end
  #@poll.link = response.parsed_response["theme"]["href"]
end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
