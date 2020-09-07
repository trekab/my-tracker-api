class Api::V1::MeasurementsController < ApplicationController
  before_action :set_measurement, only: %i[show update destroy]
  before_action :check_login, only: %i[create update destroy]

  def index
    @measurements = Measurement.all
    render json: MeasurementSerializer.new(@measurements).serializable_hash
  end

  def show
    render json: MeasurementSerializer.new(@measurement).serializable_hash
  end

  def create
    measurement = Measurement.create(measurement_params)
    if measurement.save
      render json: MeasurementSerializer.new(measurement).serializable_hash, status: :created
    else
      render json: { errors: measurement.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @measurement.update(measurement_params)
      render json: MeasurementSerializer.new(@measurement).serializable_hash
    else
      render json: @measurement.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @measurement.destroy
    head 204
  end

  private

    def measurement_params
      params.require(:measurement).permit(:total, :product_id, :category_id)
    end

    def set_measurement
      @measurement = Measurement.find(params[:id])
    end
end
