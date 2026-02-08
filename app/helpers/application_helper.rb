module ApplicationHelper
  include ActionView::Helpers::NumberHelper
  def format_price(cents)
    number_to_currency(
      cents,
  unit: "rs ",
  precision: 0,
  delimeter: ","
    )
  end
end
