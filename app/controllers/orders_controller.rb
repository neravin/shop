class OrdersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @total = 0
    @order.line_items.each do |item|
      @total += (item.product.price * item.quantity )
    end
  end

  # GET /orders/new
  def new
    if @cart.line_items.empty?
      redirect_to store_index_path, notice: "Your cart is empty"
      return
    end
    @is_order = 1
    @order = Order.new
  end



  # POST /orders
  # POST /orders.json

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    
    respond_to do |format|
      if !@order.line_items.empty?
        if @order.save

          if current_client
            @order.update_attribute(:client_id, current_client.id)
          end
        	Cart.destroy(session[:cart_id])
        	session[:cart_id] = nil
        	OrderNotifier.received(@order).deliver
        	format.html { redirect_to home_path, notice: 'Thank you for your order.' }
          format.json { render :show, status: :created, location: @order }
        else
  	
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      else
        format.html { 
          redirect_to home_path, notice: "Корзина пуста. Попробуйте ещё раз"
        }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_qty
    item = LineItem.find(params[:id])
    qty = item.quantity

    respond_to do |format|
      if params[:add]
        item.update_attribute(:quantity, qty += 1)
          format.html { redirect_to new_order_path, :notice => 'Item was added' }
          format.js { @current_item = @line_item }
      elsif params[:sub]
        if qty > 1
          item.update_attribute(:quantity, qty -= 1)
          format.html { redirect_to new_order_path, :notice => 'Item was removed' }
          format.js { @current_item = @line_item }
        else
          item.destroy
          format.html { redirect_to new_order_path, :notice => 'Item was destroyed' }
          format.js
        end
      end
    end
  end

  
  # GET /orders/1/edit
  /
  def edit
  end
  /
  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  
  /def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  /
  # DELETE /orders/1
  # DELETE /orders/1.json
  /
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  /

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :adress, :email, :pay_type)
    end
end
