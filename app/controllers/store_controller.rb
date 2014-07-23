class StoreController < ApplicationController
  skip_before_action :authorize#, only: :composition
  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.order(:title)
    @search = Product.search(params[:q])
    @products = @search.result
    @categories = Category.all
    
  end

end
