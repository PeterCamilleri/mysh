# coding: utf-8

require_relative 'internal/actions/actions_path'
require_relative 'internal/action'
require_relative 'internal/action_pool'
require_relative 'internal/manage'
require_relative 'internal/format'
require_relative 'internal/decorate'

#Load up the internal actions!
begin
  current_file = ""

  Dir[Mysh::Action::ACTIONS_PATH + '*.rb'].each {|file| require (current_file = file) }

rescue
  puts "Error loading #{current_file}"
end
