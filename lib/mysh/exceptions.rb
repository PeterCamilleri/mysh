# coding: utf-8

# The abstract base exception of the mysh.
class MyshException < StandardError; end

# Exit the current mysh processing loop.
class MyshExit < MyshException; end

# Stop further output from a verbose command.
class MyshStopOutput < MyshException; end
