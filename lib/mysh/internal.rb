# coding: utf-8

require_relative 'commands/command_path'
require_relative 'support/frame'
require_relative 'support/command_pool'
require_relative 'support/manage'
require_relative 'support/parse'
require_relative 'support/format'
require_relative 'support/decorate'
require_relative 'support/handlebars'

#Load up the internal commands!
Dir[Mysh::Command::COMMAND_PATH + '*.rb'].each {|file| require file }
