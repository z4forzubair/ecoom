class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    authorize @orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    authorize @order
  end

  # GET /orders/new
  def new
    @auth_order = Order.new
    authorize @auth_order
    # @ordered = Cart.where(user_id: current_user.id, id:)
    @order = $carts
    # @order = Cart.where(user_id: current_user.id)
    # authorize @order    # it is calling carts#new    !!!!!!!!!!!!!
  end

  # GET /orders/1/edit
  def edit
    authorize @order
  end

  # POST /orders
  # POST /orders.json
  def create
    # @order = Order.new(order_params)
    @order = Order.new
    evaluate_order # it populates the order object
    authorize @order

    # respond_to do |format|
    if @order.save
      evaluate_product_order_and_clear_cart # it adds the enteries to product_order table
      # reduce_product_quantity
      # clear_cart
      # format.html { redirect_to @order, notice: 'Order was successfully created.' }
      # format.json { render :show, status: :created, location: @order }
      redirect_to products_path, notice: 'Order has been successfully placed'
    else
      render :new, notice: 'errors'
      # format.html { render :new }
      # format.json { render json: @order.errors, status: :unprocessable_entity }

    end
    # end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    authorize @order
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

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    authorize @order
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.fetch(:order, {})
  end

  # Evaluate order attributes
  def evaluate_order
    @order.user_id = current_user.id
    # @cart=Cart.where(user_id: current_user.id)
    @cart = $carts
    @order.no_of_products = @cart.count
    # finding total price and discount
    totalDiscount = totalAmount = 0
    @cart.each do |c|
      totalAmount += c.product.price
      totalDiscount += c.product.discount
      # totalDiscount+=c.product.price
    end
    @order.total_discount = totalDiscount
    @order.total_amount = totalAmount
    @order.total_bill = @order.total_amount - @order.total_discount
  end

  # Evaludate ProductOrder attributes
  def evaluate_product_order_and_clear_cart # To merge it with the upper function, i.e. to optimize
    # @product_order=ProductOrder.new
    # @product_order.order_id=@order.id
    # @product_order.product_id=@cart.product_id
    # @cart=Cart.where(user_id: current_user.id)
    # @product_order=ProductOrder.new
    @cart.each do |c| # not getting saved
      @product_order = ProductOrder.new
      @product_order.order_id = @order.id
      @product_order.product_id = c.product_id
      @product_order.quantity = c.quantity
      @product_order.discount = c.product.discount
      @product_order.save
      # delete the cart entry
      c.destroy
    end
  end

  # Clear Cart table for the current user
  def clear_cart
    @cart.each(&:destroy)
  end
end
