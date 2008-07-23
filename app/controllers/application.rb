class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  before_filter :authenticate, :authorize 

  protected
  
  #must be overriden in every controller!
  def authorize
    raise Unauthorized
  end

  def readonly_action?
    action_name.match(/\Alist|show/)    
  end
  
  def write_action?
    action_name.match(/create|update|destroy/)
  end
  
  def create_action?
    action_name.match('create')
  end
  
  def update_action?
    action_name.match('update')
  end

  def destroy_action?  
    action_name.match('destroy')
  end
  
  def allowed_action?(*methods)
    methods.each do |method|
      return action_name.match(method)
    end
    
    false
  end

  def administrator?
    @authenticated_user.instance_of?(Administrator)
  end
  
  def receptionist_user?
    @authenticated_user.instance_of?(ReceptionistUser)
  end
  
  def receptionist_manager?
    @authenticated_user.instance_of?(ReceptionistManager)
  end
  
  def receptionist?
    is_reseptionist_user || is_reseptionist_manager
  end
  
  def rescue_action_with_handler(exception)
    case exception
    when Unauthenticated
      render :status => '401 Unauthorized', :text => "Username/password not accepted!\n\nUser: #{exception.username}\nPassword: #{exception.password}"
    when Unauthorized
      render :status => '403 Forbidden', :text => "Operation not allowed\n\nController: #{controller_name}\nAction: #{action_name}"
    when ActiveRecord::RecordNotFound
      render :status => '404 Not found', :text => exception.to_s
    when ActiveRecord::StatementInvalid
      render :status => '409 Conflict', :text => exception.to_s
    else
      render :status => '500 Internal Server Error', :text => exception.to_s
      raise exception
    end

    logger.fatal(exception)
  end
  
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

  def authenticate    
    @authenticated_user = nil
    authenticate_with_http_basic do |user, pass|
      @authenticated_user = User.first(:conditions => {:username => user, :password => Digest::SHA1.hexdigest(pass)})

      return true if @authenticated_user

      raise Unauthenticated.new(user, pass)
    end
    
    raise Unauthenticated.new
  end
  
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
