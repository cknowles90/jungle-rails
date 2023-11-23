class ProductsController < ApplicationController
  skip_before_action :authorize, only: :index
  
  def index
    Rails.logger.debug("Request to ProductsCotroller#index")
    @products = Product.all.order(created_at: :desc)
    render :index 
  end

  def show
    @product = Product.find params[:id]
    render :show
  end

end
