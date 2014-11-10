require "test_helper"

describe HomeController do
  test "should get home" do
    get :pflag
    assert_response :success
	assert_select "title", "Chapter Map"

  end
end
