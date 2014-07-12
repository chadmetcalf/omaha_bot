begin
  require 'dotenv'
  Dotenv.load if defined?(Dotenv)
  ENV['env'] ||= "production"
rescue LoadError
  # Must be in a non bundled env
  # No problem, fall back on some assumtions.
  ENV['env'] = "production"
end

begin
  # use `bundle install --standalone' to get this...
  require_relative '../bundle/bundler/setup'
rescue LoadError
  # fall back to regular bundler if the developer hasn't bundled standalone
  Bundler.require(:default, ENV['env']) if defined?(Bundler)
end

require_relative 'omaha_bot/core'
require_relative 'omaha_bot/settings'
require_relative 'omaha_bot/logger'
require_relative 'omaha_bot/parser'
require_relative 'omaha_bot/match'
require_relative 'omaha_bot/player'
require_relative 'omaha_bot/gene_player'
require_relative 'omaha_bot/opponent_player'
require_relative 'omaha_bot/training_player'

STDOUT.sync = true

module OmahaBot
  extend Core

  def self.runner
    match.play
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
