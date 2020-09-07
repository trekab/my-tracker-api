class Api::V1::CategoriesController < ApplicationController
  before_action :check_admin, only: %i[create update destroy]
  before_action :set_category, only: %i[update destroy]

  def index
    @categories = Category.all
    render json: CategorySerializer.new(@categories).serializable_hash
  end

  def create
    category = current_user.categories.build(category_params)

    if category.save
      render json: CategorySerializer.new(category).serializable_hash, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: CategorySerializer.new(@category).serializable_hash
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    head 204
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.find(params[:id])
    end
end
