module OmahaBot
  class Logger < ::Logger
    def self.instance
      @instance ||= ::Logger.new(STDOUT)
    end

    def self.setup_logger
      logger = self.instance
      logger.level = self::WARN
      logger.level = self::INFO if ENV['env'] == 'development'
      return logger
    end
  end
end
