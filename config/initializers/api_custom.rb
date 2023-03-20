# frozen_string_literal: true

##
# Constants used in this API
#
MY_APP       = 'Fedex quoter API'
DEFAULT_FROM = 'no-reply@aquiderecho.com'
CREDENTIALS  = {
  key: Rails.application.credentials.dig(:fedex, :key),
  password: Rails.application.credentials.dig(:fedex, :password),
  account_number: Rails.application.credentials.dig(:fedex, :account_number),
  meter_number: Rails.application.credentials.dig(:fedex, :meter_number)
}.freeze

puts '*' * 50
puts "IF you aren't in ExceptionHandler list: #{Rails.configuration.exception_handler[:email]}"
puts 'CHANGE it in config/application.rb, line 16...'
puts '=' * 50
puts "Current environment is #{Rails.env}..."
puts '*' * 50
