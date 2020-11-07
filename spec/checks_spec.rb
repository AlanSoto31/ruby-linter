require '../lib/checks'

describe Checks do
  let(:test) { Checks.new }

  let(:file) { File.open('test_for_spec.rb') }

  let(:op_paren) { '(()' }

  let(:cl_paren) { ')()' }

  let(:order_paren) { ')()(' }

  let(:lines_paren) { 
  ')()(
    (()
    (((' 
  }

  describe '#missing_tag' do
    context 'Testing missing_tag method' do

      #it 'Checks if the method read a file' do
      #  expect { test.missing_tag(file) }.to output('OK').to_stdout
      #end

      it 'Checks if the method catch an extra opening parentheses' do 
        expect { test.missing_tag(op_paren)}.to output("\"You have an extra ( in line 1\"\n").to_stdout
      end

      it 'Checks if the method catch an extra closing parentheses' do 
        expect { test.missing_tag(cl_paren)}.to output("\"You have an extra ) in line 1\"\n").to_stdout
      end

      it 'Checks if the method catch a closing parentheses before an opening parentheses' do 
        expect { test.missing_tag(order_paren)}.to output("\"You have an extra ) in line 1\"\n").to_stdout
      end

      it 'Checks if the method catch extra parentheses in several lines' do 
        expect { test.missing_tag(lines_paren)}.to output("\"You have an extra ) in line 1\"\n\"You have an extra ( in line 2\"\n\"You have an extra ( in line 3\"\n").to_stdout
      end
    end
  end
end