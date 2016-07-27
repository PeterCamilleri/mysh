# coding: utf-8

require_relative 'internal/klass.rb'
require_relative 'internal/parse.rb'
require_relative 'internal/instance.rb'

#Load up the commands!
Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }
