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
    # {"name"=>"Page Views", "application"=>"Bloccit", "topic_name"=>"officiis enim laboriosam quibusdam aperiam qui voluptatum et iusto", "app_user"=>"4", "app_owner"=>"douglaswalter2@gmail.com", "event"=>{"name"=>"Page Views"}}
    @event = Event.create(name: params[:name], property_1: params[:topic_name], property_2: params[:app_owner])

    respond_to do |format|
      format.json { head :ok }
      format.js
    end
  end


  private
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
