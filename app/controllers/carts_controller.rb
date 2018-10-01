class CartsController < ApplicationController
  before_action :set_cart, only: %i[show edit update destroy]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.new
    authorize @carts, :user_logged_in?
    @carts = Cart.where(user_id: current_user.id)
    @carts.each do |c|
      if c.product.flag == false
        c.destroy
      else
        if c.quantity > c.product.quantity
          c.quantity = c.product.quantity
          c.update(cart_params)
        end
      end
    end
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
    @notice = CartServices.verify_quantity_in_create
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
  # it updates the cart only when called through the create controller
  def update
    @cart = CartServices.get_cart
    authorize @cart
    @notice = CartServices.verify_quantity_in_update
    if @notice == 'product_quantity' || @notice == 'update'
      @notice = CartServices.update_cart
      render_alert(@notice)
    else
      render_alert(@notice)
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
