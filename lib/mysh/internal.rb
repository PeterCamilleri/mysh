# coding: utf-8

require_relative 'internal/klass'
require_relative 'internal/parse'
require_relative 'internal/instance'
require_relative 'internal/decorate'

#Load up the commands!
Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }
