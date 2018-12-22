# coding: utf-8

# The abstract base exception of the mysh.
class MyshException < StandardError; end

# Exit the current mysh processing loop.
class MyshExit < MyshException; end

# Display usage info and exit.
class MyshUsage < MyshException; end
