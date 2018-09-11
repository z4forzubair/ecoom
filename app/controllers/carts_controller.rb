class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    # @cart = Cart.new(cart_params)
    @cart = Cart.new
    product = Product.find(params[:product_id])
    @cart.product_id = product.id
    @cart.user_id = current_user.id
    @cart.quantity = 1

    # respond_to do |format|
      if @cart.save
        # format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        # format.json { render :show, status: :created, location: @cart }
        # format.html { redirect_to controller: 'products', notice: 'Cart was successfully created.' }
        # format.json { render :index, status: :created, location: 'products' }
        # redirect_to action: 'index', controller: 'products'
        redirect_to products_path, notice: 'Cart was added successfully'
        # redirect_to :controller => 'products', :action => 'index'
      else
        render :new, notice: 'errors'
        # format.html { render :new }
        # format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    # end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
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
      params.fetch(:cart, {}) #it is a hash for avoiding null array
      # params.require(:cart).permit(:user_id, :product_id, :quantity)
    end
end