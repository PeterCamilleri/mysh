# coding: utf-8

#* support/parse.rb -- mysh internal command parser.
module Mysh

  #The mysh internal command instance data and methods.
  class InternalCommand

    #Parse a command string for use by commands.
    #<br>Endemic Code Smells
    #* :reek:TooManyStatements
    def self.parse(input)
      result, read_point = [], input.chars.each

      loop do
        begin
          next_parse_char = read_point.next
        rescue StopIteration
          break
        end

        if next_parse_char == '"'
          result.concat(get_string(read_point))
        elsif next_parse_char != ' '
          result.concat(get_parameter(next_parse_char, read_point))
        end
      end

      [@commands[result.shift], result]
    end

    private

    #Get a string parameter.
    #<br>Endemic Code Smells
    #* :reek:TooManyStatements
    def self.get_string(read_point)
      result = ""

      loop do
        begin
          next_str_char = read_point.next
        rescue StopIteration
          break
        end

        break if next_str_char == '"'

        result << next_str_char
      end

      [result]
    end

    #Get a parameter.
    #<br>Endemic Code Smells
    #* :reek:TooManyStatements
    def self.get_parameter(first_char, read_point)
      result = first_char

      loop do
        begin
          next_parm_char = read_point.next
        rescue StopIteration
          break
        end

        if next_parm_char == '"'
          return [result].concat(get_string(read_point))
        elsif next_parm_char == ' '
          break
        else
          result << next_parm_char
        end
      end

      [result]
    end

  end

end
