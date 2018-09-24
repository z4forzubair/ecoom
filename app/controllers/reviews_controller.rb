class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
    authorize @reviews
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    authorize @review
  end

  # GET /reviews/new
  def new
    @review = Review.new
    authorize @review
  end

  # GET /reviews/1/edit
  def edit
    authorize @review
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    authorize @review, :user_logged_in?
    @review.user = current_user
    # @product = Product.find(params[:product_id]) # Not a good approach
    authorize @review
    if @review.save
      respond_to do |format|
        # format.html { redirect_to @review, notice: 'Review was successfully created.' }
        # format.json { render :show, status: :created, location: @review }
        # redirect_to @product, notice: 'Review was added successfully'
        format.js
      end
    else
      render :new, notice: 'errors'
      # format.html { render :new }
      # format.json { render json: @review.errors, status: :unprocessable_entity }
    end
    # end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    authorize @review
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    authorize @review
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def review_params
    params.fetch(:review, {})
    params.permit(:revcontent, :product_id, :comment_id)
  end
end
