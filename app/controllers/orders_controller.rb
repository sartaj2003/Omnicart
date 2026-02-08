class OrdersController < ApplicationController
  before_action :authenticate_user!

  ############################################
  # CREATE RAZORPAY ORDER
  ############################################

  def create
      OrderMailer.confirmation(@order).deliver_later


    Razorpay.setup(
      ENV["RAZORPAY_KEY_ID"],
      ENV["RAZORPAY_KEY_SECRET"],
    )
    cart = current_user.cart

    if cart.cart_items.empty?
      return render json: { error: "Cart is empty" }, status: :unprocessable_entity
    end

    total_amount = cart.cart_items.includes(:product).sum do |item|
      item.product.price_cents * item.quantity
    end

    razorpay_order = Razorpay::Order.create(
      amount: total_amount, # already in paise
      currency: "INR",
      receipt: "order_#{SecureRandom.hex(5)}"
    )

    render json: {
      razorpay_order_id: razorpay_order.id,
      amount: total_amount,
      key: ENV.fetch("RAZORPAY_KEY_ID")
    }
  end

  ############################################
  # VERIFY PAYMENT
  ############################################

  def verify_payment
    payment_id = params[:razorpay_payment_id]
    order_id   = params[:razorpay_order_id]
    signature  = params[:razorpay_signature]

    begin
      Razorpay::Utility.verify_payment_signature(
        razorpay_order_id: order_id,
        razorpay_payment_id: payment_id,
        razorpay_signature: signature
      )

      cart = current_user.cart

      total_amount = cart.cart_items.includes(:product).sum do |item|
        item.product.price_cents * item.quantity
      end

      order = current_user.orders.create!(
        total_amount: total_amount,
        status: "paid",
        payment_method: "razorpay",
        customer_name: current_user.email
      )

      cart.cart_items.each do |item|
        order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          price_cents: item.product.price_cents
        )

        item.product.decrement!(:stock, item.quantity)
      end

      cart.cart_items.destroy_all

      render json: { success: true, order_id: order.id }


    rescue Razorpay::SignatureVerificationError
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  ############################################
  # SHOW ORDER
  ############################################

  def show
    @order = current_user.orders.find(params[:id])
  end
end
