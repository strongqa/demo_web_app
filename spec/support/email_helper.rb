module EmailHelper
  def sent_email(number)
    ActionMailer::BAse.deliveries[number]
  end
end