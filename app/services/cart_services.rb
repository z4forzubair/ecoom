# service for thining carts controller
class CartServices
  def self.build_cart(params)
    @params = params
    @cart = Cart.new(params)
  end

  def self.verify_quantity
    @notice = ''
    quantity = @params[:quantity]
    quantity = quantity.to_i
    if quantity < 1 || quantity.nil?
      @notice = 'Enter a valid number of items.'
    else
      product_temp = Product.find(@params[:product_id])
      cart = Cart.where(product_id: product_temp.id, user: @params[:user]).first
      if cart.nil?
        @notice = if product_temp.quantity.nil? || product_temp.flag == false
                    'Product not available'
                  elsif @cart.quantity > product_temp.quantity
                    "Only #{product_temp.quantity} items are available"
                  else
                    'no error found'
                  end
      else
        @notice = 'update'
      end
    end
  end

  def self.create_cart
    @notice = if @cart.save!
                'Cart was added successfully'
              else
                'There was some error'
              end
  end
end
