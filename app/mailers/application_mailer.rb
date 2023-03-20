# frozen_string_literal: true

##
# Parent class of mailers
#
# Hint:
# It uses AWS SES service
#
class ApplicationMailer < ActionMailer::Base
  default from: DEFAULT_FROM
  layout 'mailer'
end
