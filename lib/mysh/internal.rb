# coding: utf-8

require_relative 'support/manage'
require_relative 'support/parse'
require_relative 'support/format'
require_relative 'support/frame'
require_relative 'support/decorate'
require_relative 'support/text_erb'

#Load up the internal commands!
Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }
