require_relative '../lib/checks'

test = Checks.new

file = File.open('test.rb')

test.paren_syn(file)

fil = File.open('test.rb')

test.doend_syn(fil)
