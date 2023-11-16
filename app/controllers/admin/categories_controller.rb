class Admin::CategoriesController < ApplicationController
  before_action :http_basic_authenticate

  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: "Category created!"
    else
      render :new
    end
  end

  private
  
  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USERNAME']
      password == ENV['ADMIN_PASSWORD']
    end
  end

  def category_params
    params.require(:category).permit(
      :name
    )
  end
end
