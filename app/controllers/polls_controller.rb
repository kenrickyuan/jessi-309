
class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy]
  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all
    @event = Event.find(params[:event_id])
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
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
    body_email = {
      "title": "#{@event.title}",
      "fields": [ {
      "title": "Please put in your email adress?",
      "type": "email"
      }, {
      "title": "And your Phonenumber?",
      "type": "phone_number"}
      ]
    }

    typeform_api = Typeform.new
    response = typeform_api.create_form(body_email)
    #@poll.link = response.parsed_response["theme"]["href"]
 #byebug

 respond_to do |format|
  if @poll.save!

    format.html { redirect_to event_polls_path(@event, @poll), notice: 'Poll was successfully created.' }
    format.json { render :show, status: :created, location: @poll }
  else
    format.html { render :new }
    format.json { render json: @poll.errors, status: :unprocessable_entity }
  end
  @poll.link = response.parsed_response["theme"]["href"]
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:typeform_id, :event_id)
    end
  end
