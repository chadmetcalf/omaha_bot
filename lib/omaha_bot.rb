require_relative 'omaha_bot/parser'
require_relative 'omaha_bot/match'
require_relative 'omaha_bot/player'

require 'logger'
require 'ostruct'
require 'dotenv'

Dotenv.load
ENV['env'] ||= "production"

Bundler.require(:default, ENV['env']) if defined?(Bundler)

module OmahaBot
  extend self

  def self.runner
    match.play
  end

  def match
    @match ||= Match.instance
  end

  def parser
    @parser ||= Parser.new
  end

  def player
    @player ||= Player.new
  class Settings < OpenStruct
    def self.instance
      @instance ||= new
    end
  end

  def opponent
    @opponent ||= Player.new
  end
  def settings
    @settings ||= Settings.instance
  end

  def logger
    @logger ||= setup_logger
  end

  private

  class Logger < ::Logger
    def self.instance
      @instance ||= ::Logger.new(STDOUT)
    end
  end
  
  def setup_logger
    logger = Logger.instance
    logger.level = Logger::WARN
    logger.level = Logger::INFO if ENV['env'] == 'development'
    return logger
  end
end


String.class_eval do
  def snakecaserize
    #gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr('-', '_').
    gsub(/\s/, '_').
    gsub(/__+/, '_').
    downcase
  end
end
