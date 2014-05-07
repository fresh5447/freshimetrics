class ApiController < ActionController::Base

  layout 'application'
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


  #disabling the CSRF protection 
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