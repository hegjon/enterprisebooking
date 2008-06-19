class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '1948db2464074b482705f0a5753118dd'

  before_filter :authenticate  
  
  def authenticate    
    @authenticated_user = nil
    authenticate_with_http_basic do |user, pass|
      if user == "jonny" and pass == "ponny" then
        @authenticated_user = user #User.authenticated_user(user, pass)
      end
      if @authenticated_user == "jonny"
        return true
      end
        
      raise Unauthorized.new(user, pass)
    end
    
    raise Unauthorized.new
  end  
  
  def rescue_action_in_public(exception)
    case exception
    when Unauthorized
      render :status => '401 Unauthorized', :text => "User: #{exception.username}\nPassword: #{exception.password}"
    when ActiveRecord::RecordNotFound
      render :status => '404 Not found', :text => exception
    when ActiveRecord::StatementInvalid
      render :status => '409 Conflict', :text => exception
    else
      render :status => '500 Internal Server Error', :text => exception
    end    
  end
  
  def local_request?
    false
  end
  
  protected
  
  def ok(entity)
    respond_format(entity, '200 OK')  
  end
  
  def created(entity)
    headers['Location'] = entity_location(entity)
    respond_format(entity, '201 Created')
  end

  def updated(entity)
    headers['Location'] = entity_location(entity)
    respond_format(entity, '200 OK')  
  end
  
  def destroyed
    respond_nothing('200 OK')
  end
  
  private
  
  def entity_location(entity)
    "/#{entity.class.to_s.downcase}/#{entity.id}"
  end
  
  def respond_nothing(status)
    render(:nothing => true, :status => status)
  end
  
  def respond_format(entity, status)
    respond_to do |format|
      format.xml {render :xml => entity.to_xml, :status => status}
      format.json {render :json => entity.to_json, :status => status}
    end     
  end  
  
end
