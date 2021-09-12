module EmailHelper
  def sent_email(number)
    ActionMailer::Base.deliveries[number]
  end
end
