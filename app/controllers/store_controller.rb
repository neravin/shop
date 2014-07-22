class StoreController < ApplicationController
  skip_before_action :authorize#, only: :composition
  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.order(:title)
    @categories = Category.all
  end

end
