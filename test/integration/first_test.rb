require "#{File.dirname(__FILE__)}/../test_helper"

class FirstTest < ActionController::IntegrationTest
  fixtures :camps

  def test_unauthorized
    get "/camp/"
    assert_response :unauthorized
  end
  
  def test_authorized
    username_password = Base64.encode64("jonny:ponny");
    get "/camp/", nil, {"Authorization" => "Basic #{username_password}"}
    assert_response :success
  end
end
