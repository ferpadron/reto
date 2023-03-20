# frozen_string_literal: true

##
# Personal demo of the jsonapi-serializer API gem
#
# Is out from the challenge
#
class ClientSerializer
  include JSONAPI::Serializer
  attributes :name, :zip, :country
  has_many :items
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
