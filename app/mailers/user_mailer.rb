class UserMailer < ApplicationMailer
  def order_email(user, order)
    @user = user
    @order = order

    mail(
      # to: @user.email,
      to: "alam2122003@gmail.com",
      subject: "Order Confirmation 🎉"
    ) do |format|
      format.html { render "order_email" }
    end
  end
end
