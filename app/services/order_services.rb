class OrderServices
  def self.build_order
    @order = Order.new
  end

  def self.evaluate_order(current_user)
    @order.user_id = current_user.id
    @carts = Cart.where(user_id: current_user.id)
    @order.no_of_products = @carts.count
    total_discount = total_amount = 0
    @carts.each do |c|
      total_amount += c.product.price
      total_discount += c.product.discount
    end
    @order.total_discount = total_discount
    @order.total_amount = total_amount
    @order.total_bill = @order.total_amount - @order.total_discount
  end

  def self.create_order
    @flag = if @order.save
              true
            else
              false
              end
  end

  def self.evaluate_product_order_and_clear_cart
    @carts.each do |c| # not getting saved
      @product_order = ProductOrder.new
      @product_order.order_id = @order.id
      @product_order.product_id = c.product_id
      @product_order.quantity = c.quantity
      @product_order.discount = c.product.discount
      @product_order.save
      c.destroy
    end
  end
end
