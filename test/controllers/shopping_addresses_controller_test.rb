require 'test_helper'

class ShoppingAddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shopping_addresses_index_url
    assert_response :success
  end

end
