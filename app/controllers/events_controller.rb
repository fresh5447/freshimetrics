class EventsController < ApplicationController
  skip_before_action :verify_authentication_controller
  skip_before_action :verify_authenticity_token
  before_filter :cors_preflight_check 
  after_filter :cors_set_access_control_headers 
 
  #neccessary in all controllers that will respond with JSON
  respond_to :json

  #trying to set CORS response headers in controller actions
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*' 
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'
  end


 
  # GET /events
  # GET /events.json
  def index
  end

  # POST /events
  # POST /events.json
  def create
    # app_owner = params['app_owner']
    # puts "*** #{params[app_owner]}"
    # puts "*** #{params['app_owner']}"
    # user = User.find_by_email(app_owner)
    # user.events.create!(event_params)

    # blocmetrics.track("some event name", {property_1: "some value", property_2: "some other value"})
    @event = Event.create(event_params)

    respond_to do |format|
      format.json { head :ok }
      format.js
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  #def destroy
   # @event.destroy
    #respond_to do |format|
     # format.html { redirect_to events_url }
      #format.json { head :no_content }
    #end
  #end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :topic_name, :app_user, :app_owner, :application)
      #params.require(:event).permit(:name, :body)
    end

     #disabling the CSRF protection 


  def permission_denied_error
   error(403, 'Permission Denied!')
  end

  def error(status, message = 'Something went wrong')
    response = {
    response_type: "ERROR",
    message: message
    }

    render json: response.to_json, status: status
  end

end
