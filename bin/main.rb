require_relative '../lib/checks'

require 'colorize'

test = Checks.new

file = File.open('test.rb')

p test.paren_syn(file)

fil = File.open('test.rb')

test.doend_syn(fil)

#puts 'No offenses'.colorize(:green) if test.err.empty?
#
#test.err.each do |key, value|
#  puts "line:#{key} Lint/Syntax: unexpected token #{value}".colorize(:red)
#end


