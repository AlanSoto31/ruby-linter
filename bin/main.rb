require_relative '../lib/checks'

require 'colorize'

test = Checks.new

file = File.open('test.rb')

test.paren_syn(file)
