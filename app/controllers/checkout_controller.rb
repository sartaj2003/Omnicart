class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = current_user.cart

    # Safety check
    if cart.nil? || cart.cart_items.empty?
      return render json: { error: "Cart is empty" }, status: :unprocessable_entity
    end

    ############################################
    # CALCULATE TOTAL
    ############################################

    total_amount = cart.cart_items.includes(:product).sum do |item|
      item.product.price_cents * item.quantity
    end

    ############################################
    # CREATE RAZORPAY ORDER
    ############################################

    razorpay_order = Razorpay::Order.create(
      amount: total_amount,   # already in paise
      currency: "INR",
      receipt: "receipt_#{SecureRandom.hex(6)}"
    )

    ############################################
    # RETURN JSON FOR JS POPUP
    ############################################

    render json: {
      order_id: razorpay_order.id,
      amount: total_amount,
      key: ENV.fetch("RAZORPAY_KEY_ID")
    }

  rescue Razorpay::Error => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
