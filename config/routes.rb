  def get_filter(map, pattern, controller, action)
    map.connect pattern, :controller => controller, :action => action, :conditions => { :method => :get }
  end
  
ActionController::Routing::Routes.draw do |map|
  #default CRUD
  map.connect '/:controller/',    :action => "list",    :conditions => { :method => :get }
  map.connect '/:controller/',    :action => "create",  :conditions => { :method => :post }
  map.connect '/:controller/:id', :action => "show",    :conditions => { :method => :get }
  map.connect '/:controller/:id', :action => "update",  :conditions => { :method => :put }
  map.connect '/:controller/:id', :action => "destroy", :conditions => { :method => :delete }
  
  #additional read-filter
  get_filter map, "/camp/:camp_id/barrack/",       "barrack", "list_by_camp"
  get_filter map, "/barrack/:barrack_id/room/",    "room",    "list_by_barrack"
  get_filter map, "/room/:room_id/booking/",       "booking", "list_by_room"
  
  get_filter map, "/booking/?arrival=:arrival",     "booking", "list_by_arrival"
  get_filter map, "/booking/?departure=:departure", "booking", "list_by_arrival"  
end
