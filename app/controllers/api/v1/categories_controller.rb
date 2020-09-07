class Api::V1::CategoriesController < ApplicationController
  before_action :check_admin, only: %i[create update destroy]

  def index
    render json: Category.all
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    head 204
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end
end
