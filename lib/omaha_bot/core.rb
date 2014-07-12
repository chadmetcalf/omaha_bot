require 'logger'

module OmahaBot
  module Core
    extend self

    def match
      @match ||= OmahaBot::Match.instance
    end

    def parser
      @parser ||= OmahaBot::Parser.new
    end

    def settings
      @settings ||= OmahaBot::Settings.instance
    end

    def logger
      @logger ||= OmahaBot::Logger.setup_logger
    end

    class Environment < ::Struct.new(:env)
      def production?
        env == "production"
      end

      def development?
        env == "development"
      end

      def test?
        env == "test"
      end
    end

    def env
      @env ||= Environment.new(ENV['env'])
    end
  end
end
