class Api::V1::CategoriesController < ApplicationController
  before_action :check_admin, only: [:create]

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

  private

    def category_params
      params.require(:category).permit(:name)
    end
end
