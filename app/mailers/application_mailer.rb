# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  # TODO: Use ENV here
  default from: 'noreply@agnos.com'
  layout 'mailer'
end
