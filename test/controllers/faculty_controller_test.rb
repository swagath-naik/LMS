require 'test_helper'

class FacultyControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get faculty_show_url
    assert_response :success
  end

end
