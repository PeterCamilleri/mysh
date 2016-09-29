# coding: utf-8

#* support/text_erb.rb -- Allow text files to embed ruby code.
module Mysh

  #The mysh embedded ruby report formatting.
  class InternalCommand

    #Process a string with embedded Ruby code.
    def process_erb_string(str)
      loop do
        pre_match, match, post_match = str.partition(/{{.*?}}/m)

        return pre_match if match.empty?

        str = pre_match + eval(match[2...-2]) + post_match
      end

    end

    #Show a file with embedded ruby handlebars.
    def show_file(name)
      puts process_erb_string(IO.read(full_name = COMMAND_PATH + name))
    rescue StandardError, ScriptError => err
      puts "Error in file: #{full_name}\n#{err.class}: #{err}"
    end

  end

end

