require_relative 'omaha/parser'
require_relative 'omaha/settings'
require_relative 'omaha/match'


module Omaha
  def self.settings
    @settings ||= Omaha::Settings.new
  end

  def self.match
    @match ||= Omaha::Match.new
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
