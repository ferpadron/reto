# frozen_string_literal: true

##
# Personal demo of the jsonapi-serializer API gem
#
# Is out from the challenge
#
class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :length, :width, :height, :distance_unit, :weight, :mass_unit
  belongs_to :client
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
