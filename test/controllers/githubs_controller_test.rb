require 'test_helper'

class GithubsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get githubs_index_url
    assert_response :success
  end

end
