# coding: utf-8

require_relative 'support/manage'
require_relative 'support/parse'
require_relative 'support/frame'
require_relative 'support/decorate'

#Load up the internal commands!
Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }
