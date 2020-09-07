require 'test_helper'

module Api
  module V1
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @category = categories(:one)
        @other_category = categories(:two)
      end

      test 'should show categories' do
        get api_v1_categories_url, as: :json
        assert_response :success
      end

      test 'should create category' do
        assert_difference('Category.count') do
          post api_v1_categories_url, params: { category: { name: 'testing' } },
                                      headers: { Authorization: JsonWebToken.encode(user_id: @category.user_id) },
                                      as: :json
        end
        assert_response :created
      end

      test 'should forbid create category' do
        assert_no_difference('Category.count') do
          post api_v1_categories_url, params: { category: { name: 'testing' } },
                                      headers: { Authorization: JsonWebToken.encode(user_id: @other_category.user_id) },
                                      as: :json
        end
        assert_response :forbidden
      end

      test 'should update category' do
        patch api_v1_category_url(@category), params: { category: { name: @category.name } },
                                              headers: { Authorization: JsonWebToken.encode(user_id: @category.user_id) },
                                              as: :json
        assert_response :success
      end

      test 'should forbid update category' do
        patch api_v1_category_url(@category), params: { category: { name: @category.name } },
                                              headers: { Authorization: JsonWebToken.encode(user_id: users(:two).id) },
                                              as: :json
        assert_response :forbidden
      end

      test 'should destroy category' do
        assert_difference('Category.count', -1) do
          delete api_v1_category_url(@category),
                 headers: { Authorization: JsonWebToken.encode(user_id: @category.user_id) },
                 as: :json
        end
        assert_response :no_content
      end

      test 'should forbid destroy category' do
        assert_no_difference('Category.count') do
          delete api_v1_user_url(@category),
                 headers: { Authorization: JsonWebToken.encode(user_id: users(:two).id) },
                 as: :json
        end
        assert_response :forbidden
      end
    end
  end
end
