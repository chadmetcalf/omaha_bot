require 'ostruct'

module OmahaBot
  class Settings < ::OpenStruct
    def self.instance
      @instance ||= new
    end
  end
end
