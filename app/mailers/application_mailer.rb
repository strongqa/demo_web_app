class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.config_for(:smtp)['user_name']
end