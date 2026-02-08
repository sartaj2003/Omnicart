class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  # ✅ ADD TO CART
  def create
    product = Product.find(params[:product_id])

    item = @cart.cart_items.find_or_initialize_by(product: product)
    item.quantity ||= 0
    item.quantity += 1
    item.save!

    redirect_to cart_path, notice: "Product added to cart 🛒"
  end


  # ✅ REMOVE FROM CART
  def destroy
    item = @cart.cart_items.find(params[:id])
    item.destroy

    redirect_to cart_path, notice: "Item removed from cart ❌"
  end


  private

  # ✅ AUTO CART CREATION (VERY IMPORTANT)
  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
