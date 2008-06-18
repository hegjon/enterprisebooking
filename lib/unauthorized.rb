class Unauthorized < Exception
  def initialize(username = nil, password = nil)
    @username = username
    @password = password
  end
  
  def username
    @username
  end
  
  def password
    @password
  end
  
end
