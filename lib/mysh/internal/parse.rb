# coding: utf-8

#* parse.rb -- mysh internal command parser.
module Mysh

  #The mysh internal command instance data and methods.
  class InternalCommand

    #Parse a command string for use by commands.
    def self.parse(input)
      result, read_point = [], input.chars.each

      loop do
        begin
          next_char = read_point.next

          if next_char == '"'
            result.concat(get_string(read_point))
          elsif next_char != ' '
            result.concat(get_parameter(next_char, read_point))
          end

        rescue StopIteration
          break
        end
      end

      [result.shift, result]
    end

    private

    #Get a string parameter.
    def self.get_string(read_point)
      result = ""

      loop do
        begin
          next_char = read_point.next

          break if next_char == '"'

          result << next_char
        rescue StopIteration
          break
        end
      end

      [result]
    end

    #Get a parameter.
    def self.get_parameter(first_char, read_point)
      result = first_char

      loop do
        begin
          next_char = read_point.next

          if next_char == '"'
            return [result].concat(get_string(read_point))
          elsif next_char == ' '
            break
          else
            result << next_char
          end
        rescue StopIteration
          break
        end
      end

      [result]
    end

  end

end
