# frozen_string_literal: true

##
# Parent class for services objects
#
class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
