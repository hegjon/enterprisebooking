require "#{File.dirname(__FILE__)}/../test_helper"

class FirstTest < ActionController::IntegrationTest
  fixtures :camps

  def test_no_user
    get "/camp/", nil                  
    assert_response :unauthorized
  end
  
  def test_unauthorized
    username_password = Base64.encode64("user_dont_exsist:blabla235566");
    get "/camp/", nil, {"Authorization" => "Basic #{username_password}"}
    assert_response :unauthorized
  end

  def test_authorized
    username_password = Base64.encode64("jonny@jonnyware.com:ponny");
    get "/camp/", nil, {"Authorization" => "Basic #{username_password}"}
    assert_response :success
  end
end
