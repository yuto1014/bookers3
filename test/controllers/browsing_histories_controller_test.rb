require 'test_helper'

class BrowsingHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get browsing_histories_index_url
    assert_response :success
  end

end
