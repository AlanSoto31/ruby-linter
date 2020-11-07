#
# things to check for linter 3000:
#
#   - missings  ) ] } end
#
#     Pass the file that we want to evaluate into a method
#     Go through all of the characters of the file
#     Use a regex to match the tag
#     Count when we match an open tag and discount when we match a close tag, the final result must be 0, otherwise the Error raise
#       if count is positive means that we miss to closed  a tag, negative means that we miss to open a tag and 0 means that everything is OK
#     The order matters, not only the quantity balance. A closing tag cannot be at the begining
#     Show the respective error message
#     Show the line where the error is
#

require_relative '../lib/checks'

test = Checks.new

file = File.open('test_for_spec.rb')

test.wrong_paren_syntax(file)
