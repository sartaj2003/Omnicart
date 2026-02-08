class OrderConfirmationJob < ApplicationJob
  queue_as :default

  def perform(user, order)
    UserMailer.order_email(user, order).deliver_now
  end
end
