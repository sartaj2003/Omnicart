class SendorderEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
 UserMailer.order_email(user).deliver_now
  end
end
