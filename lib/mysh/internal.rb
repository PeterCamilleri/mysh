# coding: utf-8

require_relative 'commands/command_path'
require_relative 'support/action'
require_relative 'support/action_pool'
require_relative 'support/manage'
require_relative 'support/parse'
require_relative 'support/format'
require_relative 'support/decorate'
require_relative 'support/handlebars'
require_relative 'support/lineage'

#Load up the internal commands!
Dir[Mysh::Action::COMMAND_PATH + '*.rb'].each {|file| require file }
