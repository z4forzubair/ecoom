class CartsController < ApplicationController
  before_action :set_cart, only: %i[show edit update destroy]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.new
    authorize @carts, :user_logged_in?
    $carts = Cart.where(user_id: current_user.id)
    $carts.each do |c|
      if c.product.flag == false
        c.destroy
      else
        if c.quantity > c.product.quantity
          c.quantity = c.product.quantity
          c.update(cart_params)
        end
      end
    end
    @carts = $carts
    authorize @carts
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    authorize @cart
  end

  # GET /carts/new
  def new
    @cart = Cart.new
    authorize @cart
  end

  # GET /carts/1/edit
  def edit
    authorize @cart
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = CartServices.build_cart(cart_params)
    authorize @cart
    @notice = CartServices.verify_quantity
    if @notice == 'update'
      update
    elsif @notice == 'no error found'
      @notice = CartServices.create_cart
      render_alert(@notice)
    else
      render_alert(@notice)
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    authorize @cart
    @old_quantity = @cart.quantity
    @cart.quantity = @old_quantity + @quantity

    if @old_quantity > @productTemp.quantity
      @cart.quantity = @productTemp.quantity
      if @cart.update(cart_params)
        # format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        # format.json { render :show, status: :ok, location: @cart }
        redirect_to products_path, notice: "You cannot add more items, Quantity available is #{@cart.quantity}"
      else
        # format.html { render :edit }
        # format.json { render json: @cart.errors, status: :unprocessable_entity }
        render :new, notice: 'errors'
      end
    elsif @cart.quantity > @productTemp.quantity
      redirect_to products_path, notice: "Product not available, you already have added #{@old_quantity} items. Only #{@productTemp.quantity - @old_quantity} more items are available."
    else
      # respond_to do |format|
      if @cart.update(cart_params)
        # format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        # format.json { render :show, status: :ok, location: @cart }
        redirect_to products_path, notice: "Cart updated successfully, new quantity available is #{@cart.quantity}"
      else
        # format.html { render :edit }
        # format.json { render json: @cart.errors, status: :unprocessable_entity }
        render :new, notice: 'errors'
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    authorize @cart
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cart
    @cart = Cart.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cart_params
    params.fetch(:cart, {}) # it is a hash for avoiding null array
    params.permit(:product_id, :quantity).merge(user: current_user)
  end

  def render_alert(notice)
    redirect_to products_path, notice: notice
  end
end
