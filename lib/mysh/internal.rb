# coding: utf-8

require_relative 'support/klass'
require_relative 'support/parse'
require_relative 'support/instance'
require_relative 'support/decorate'

#Load up the internal commands!
Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }
