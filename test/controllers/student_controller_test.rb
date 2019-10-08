require 'test_helper'

class StudentControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get student_show_url
    assert_response :success
  end

end
