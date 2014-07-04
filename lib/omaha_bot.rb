require_relative 'omaha_bot/parser'
require_relative 'omaha_bot/match'

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
    @parser ||= OmahaBot::Parser.new
  end

  class Settings < OpenStruct; end
  def settings
    @settings ||= OmahaBot::Settings.new
  end

  class Logger < Logger; end
  def logger
    @logger || setup_logger
  end

  private

  def setup_logger
    @logger = OmahaBot::Logger.new(STDOUT)
    @logger.level = Logger::WARN
    @logger.level = Logger::DEBUG if ENV['env'] == 'development'
    return @logger
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
