require 'test_helper'

class CreditCardsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get index" do
    get credit_cards_index_url
    assert_response :success
  end

end
