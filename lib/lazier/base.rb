module Lazier
  class Base
    def self.configure
      yield configuration
    end

    def self.configuration
      @configuration ||= Lazier::Configuration.new
    end
  end
end
