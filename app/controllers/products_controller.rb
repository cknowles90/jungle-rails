class ProductsController < ApplicationController

  def index
    # uses MODEL to fetch data from ('MVC' design)
    @products = Product.all.order(created_at: :desc)
    # VIEW  - located in views file
    render :index # implicite - not
  end

  def show
    @product = Product.find params[:id]
    @msg = "Product_controller.rb"
    render :show
    # render 'show' just works for this ^
    # render 'show' also works - best for getting from other paths 'shared/show' etc
    puts "Product_controller.rb"
  end

end
