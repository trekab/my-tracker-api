require 'test_helper'

class Api::V1::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    @invalid_category = categories(:two)
  end

  test "should show categories" do
    get api_v1_categories_url(), as: :json
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post api_v1_categories_url, params: { category: { name: 'testing'}},
      headers: { Authorization: JsonWebToken.encode(user_id: @category.user_id) },
      as: :json
    end
    assert_response :created
  end

  test "should forbid create category" do
    assert_no_difference('Category.count') do
      post api_v1_categories_url, params: { category: { name: 'testing'}},
      headers: { Authorization: JsonWebToken.encode(user_id: @invalid_category.user_id) },
      as: :json
    end
    assert_response :forbidden
  end
end
