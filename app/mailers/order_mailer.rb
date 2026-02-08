class OrderMailer < ApplicationMailer
  default from: "alam2122003@gmail.com"

  def confirmation(order)
    @order = order
    mail(
      # to: order.user.email,
      to: "alam2122003@gmail.com",
      subject: "Your Omnicart Order is Confirmed 🎉"
    )
  end
end
