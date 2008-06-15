#    This file is part of EnterpriseBooking.
#
#    EnterpriseBooking is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    EnterpriseBooking is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with EnterpriseBooking.  If not, see <http://www.gnu.org/licenses/>.

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
    end
    if @authenticated_user != "jonny"
      raise ActiveResource::UnauthorizedAccess.new
    else
      return true
    end
  end  
  
  def rescue_action_in_public(exception)
    case exception
    when ActiveRecord::RecordNotFound
      render :text => exception, :status => "404 Not found"
    when ActiveRecord::StatementInvalid
      render :text => exception, :status => "409 Conflict"
    else
      render :html => '<html><body><h1>500 Internal Server Error</h1></body></html>', :status => '500 Internal Server Error'
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
    respond_nothing
  end
  
  private
  
  def entity_location(entity)
    "/#{entity.class.to_s.downcase}/#{entity.id}"
  end
  
  def respond_nothing
    render(:nothing => true, :status => '200 OK')
  end
  
  def respond_format(entity, status)
    respond_to do |format|
      format.xml {render :xml => entity.to_xml, :status => status}
      format.json {render :json => entity.to_json, :status => status}
    end     
  end  
  
end
