# coding: utf-8

require_relative 'commands/command_path'
require_relative 'internal/action'
require_relative 'internal/action_pool'
require_relative 'internal/manage'
require_relative 'internal/format'
require_relative 'internal/decorate'

#Load up the internal commands!
Dir[Mysh::Action::ACTIONS_PATH + '*.rb'].each {|file| require file }
