class Api::V1::MeasurementsController < ApplicationController
  before_action :set_measurement, only: %i[show update destroy]
  before_action :check_login, only: %i[create update destroy]

  def index
    render json: Measurement.all
  end

  def show
    render json: @measurement
  end

  def create
    measurement = Measurement.create(measurement_params)
    if measurement.save
      render json: measurement, status: :created
    else
      render json: { errors: measurement.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @measurement.update(measurement_params)
      render json: @measurement
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
