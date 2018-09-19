class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.flagged
    authorize @products
    @falseproducts = Product.unflagged
  end

  # GET /products/1
  # GET /products/1.json
  def show
    authorize @product
  end

  # GET /products/new
  def new
    # authorize Product
    @product = Product.new
    authorize @product
  end

  # GET /products/1/edit
  def edit
    authorize @product
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.added_by_user_id=current_user.id
    authorize @product

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    authorize @product
    @product.added_by_user_id=current_user.id
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    authorize @product
    # @product.deleted_by_user_id=current_user.id
    # To set the deleted_by_user_id here when updating the flag only
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      begin
  			@product=Product.find(params[:id])
  		rescue => ex
  			redirect_to action: 'index'
  		end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
       # params.fetch(:product, {})
      params.require(:product).permit(:id, :name, :description, :price, :cost, :discount, :quantity, :added_by_user_id, :deleted_by_user_id)
    end
end
