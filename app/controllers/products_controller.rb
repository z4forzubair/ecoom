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
    @images = Image.where(imageable_id: @product.id)
    @reviews = Review.where(product_id: @product.id)
  end

  # GET /products/new
  def new
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
    authorize @product
    if params[:images].nil?
      @product.errors.add('Image Error:', 'No Image selected')
      render_alert('image error')
    else
      counter = params[:images]['image'].count
      if counter > 5
        @image_notice = 'Five images added, you cannot upload more than five images'
      end
      if @image_notice.nil?
        if @product.save
          save_images
          render_alert('success')
        else
          render_alert('errors')
        end
      else
        @product.errors.add('Image Error:', 'Five images added, you cannot upload more than five images')
        render_alert('image errors')
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    authorize @product
    @product.added_by_user_id = current_user.id
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
    if @product.flagged?
      set_params
      @product.save
    else
      @product.destroy
    end
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  rescue StandardError => ex
    redirect_to action: 'index', notice: 'Product not found.'
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    # params.fetch(:product, {})
    params.require(:product).permit(:name, :description, :price, :cost, :discount, :quantity, images_attributes: [:image])
  end

  def image_params
    params.require(:product).permit(:image)
  end

  def set_params
    @product.quantity = 0
  end

  def save_images
    params[:images]['image'].each do |a|
      @image = @product.images.create!(image: a)
    end
  end

  def render_alert(flag)
    respond_to do |format|
      if flag == 'success'
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
end
