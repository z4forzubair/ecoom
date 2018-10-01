# service for thining carts controller
class CartServices
  def self.build_cart(params)
    @params = params
    @cart = Cart.new(params)
  end

  def self.verify_quantity_in_create
    @notice = ''
    @quantity = @params[:quantity]
    @quantity = @quantity.to_i
    if @quantity < 1 || @quantity.nil?
      @notice = 'Enter a valid number of items.'
    else
      @product_temp = Product.find(@params[:product_id])
      cart = Cart.where(product_id: @product_temp.id, user: @params[:user]).first
      if cart.nil?
        @notice = if @product_temp.quantity.nil? || @product_temp.flag == false
                    'Product not available'
                  elsif @cart.quantity > @product_temp.quantity
                    "Only #{@product_temp.quantity} items are available"
                  else
                    'no error found'
                  end
      else
        @cart = cart
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

  # functions for update
  def self.get_cart
    @cart
  end

  def self.verify_quantity_in_update
    @old_quantity = @cart.quantity
    @cart.quantity = @old_quantity + @quantity
    if @old_quantity > @cart.quantity
      @cart.quantity = @product_temp.quantity
      @notice = 'product_quantity'
    elsif @cart.quantity > @product_temp.quantity
      @notice = "Product not available, you already have added #{@old_quantity} items. Only #{@product_temp.quantity - @old_quantity} more items are available."
    else
      @notice = 'update'
    end
  end

  def self.update_cart
    if @cart.save
      if @notice == 'product_quantity'
        @notice = "You cannot add more items, Quantity available is #{@cart.quantity}"
      else
        @notice = "Cart updated successfully, new quantity available is #{@cart.quantity}"
      end
    else
      @notice = 'errors'
    end
  end
end
