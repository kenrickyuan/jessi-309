
class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:show]
  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all
    @event = Event.find(params[:event_id])
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
    typeform = @poll.typeform_id
    typeform_api = Typeform.new
    response = typeform_api.responses(typeform)

    responses = []
    show = response.parsed_response["items"]
    show.each do |elements|
      elements["answers"].each do |answer|
        responses << answer["choices"]["labels"]
      end
    end
    @count = Hash.new(0)
    responses.flatten.each do |label|
      @count[label] += 1
    end
    @count
    @length = show.length
  end

  # GET /polls/new
  def new
    @poll = Poll.new
    @event = Event.find(params[:event_id])
  end

  # GET /polls/1/edit
  def edit
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)
    @event = Event.find(params[:event_id])
    @poll.event = @event
    choic = []

    params["choices"].each do |choice|
      choic << { label:choice }
    end

    body = {
      "title": "#{@event.title}",
      "fields": [ {
        "title": "#{@poll.question}",
        "type": "multiple_choice",
        "properties": {
          "description": "Which location/s do you prefer?",
          "allow_multiple_selection": true,
          "allow_other_choice": true,
          "choices": choic
        }
      }
    ]
  }

  typeform_api = Typeform.new
  response = typeform_api.create_form(body)
  @poll.link = response.parsed_response["_links"]["display"]
  @poll.typeform_id = response.parsed_response["id"]
  respond_to do |format|
    if @poll.save!

      format.html { redirect_to event_polls_path(@event), notice: 'Poll was successfully created.' }
    else
      format.html { render :new }
    end
  #@poll.link = response.parsed_response["theme"]["href"]
end
end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:typeform_id, :event_id, :link, :form_title, :field_type, :field_title)
    end
  end
