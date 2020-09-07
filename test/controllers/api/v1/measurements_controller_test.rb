require 'test_helper'

class Api::V1::MeasurementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @measurement = measurements(:one)
  end

  test "should show measurements" do
    get api_v1_measurements_url(), as: :json
    assert_response :success
  end

  test "should show measurement" do
    get api_v1_measurement_url(@measurement), as: :json
    assert_response :success

    json_response = JSON.parse(self.response.body)
    assert_equal @measurement.id, json_response['id']
  end

  test 'should create measurement' do
    assert_difference('Measurement.count') do
      post api_v1_measurements_url,
        params: { measurement: { product_id: @measurement.product_id, category_id: @measurement.category_id, total: @measurement.total } },
        headers: { Authorization: JsonWebToken.encode(user_id: @measurement.product.user_id) },
        as: :json
    end
    assert_response :created
  end

  test 'should forbid create measurement' do
    assert_no_difference('Measurement.count') do
      post api_v1_measurements_url,
        params: { measurement: { product_id: @measurement.product_id, category_id: @measurement.category_id, total: @measurement.total } },
        as: :json
    end
    assert_response :forbidden
  end

  test 'should update measurement' do
    patch api_v1_measurement_url(@measurement),
      params: { measurement: { product_id: @measurement.product_id, category_id: @measurement.category_id, total: @measurement.total } },
      headers: { Authorization: JsonWebToken.encode(user_id: @measurement.product.user_id) },
      as: :json
    assert_response :success
  end

  test 'should forbid update measurement' do
    patch api_v1_measurement_url(@measurement),
      params: { measurement: { product_id: @measurement.product_id, category_id: @measurement.category_id, total: @measurement.total } },
      as: :json
    assert_response :forbidden
  end

  test "should destroy measurement" do
    assert_difference('Measurement.count', -1) do
      delete api_v1_measurement_url(@measurement), headers: {
      Authorization: JsonWebToken.encode(user_id: @measurement.product.user_id) },
      as: :json
    end
    assert_response :no_content
  end

  test "should forbid destroy measurement" do
    assert_no_difference('Measurement.count') do
      delete api_v1_measurement_url(@measurement), as: :json
    end
    assert_response :forbidden
  end


end
