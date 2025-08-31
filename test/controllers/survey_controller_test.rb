require "test_helper"

class SurveyControllerTest < ActionDispatch::IntegrationTest
  test "should get save" do
    get survey_save_url
    assert_response :success
  end

  test "should get next" do
    get survey_next_url
    assert_response :success
  end
end
