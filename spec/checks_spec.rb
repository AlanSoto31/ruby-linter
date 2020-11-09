require '../lib/checks'

describe Checks do

  describe '#paren_syn' do
    let(:test) { Checks.new }

    let(:file) { File.open('paren_test.rb') }

    let(:op_paren) { '(()' }

    let(:cl_paren) { ')()' }

    let(:order_paren) { ')()(' }

    let(:lines_paren) do
      ')()(
      (()
      ((('
    end

    let(:lines_w_str) do
      ')()(
      "extra ("
      /\(/
      ((('
    end

    context 'Testing paren_syn method' do
      it 'Checks if the method read a file' do
        expect { test.paren_syn(file) }.to output("\"line:1 extra (\"\n\"line:1 extra )\"\n").to_stdout
      end

      it 'Checks if the method catch an extra opening parentheses' do
        expect { test.paren_syn(op_paren) }.to output("\"line:1 extra (\"\n").to_stdout
      end

      it 'Checks if the method catch an extra closing parentheses' do
        expect { test.paren_syn(cl_paren) }.to output("\"line:1 extra )\"\n").to_stdout
      end

      it 'Checks if the method catch a closing parentheses before an opening parentheses' do
        expect { test.paren_syn(order_paren) }.to output("\"line:1 extra )\"\n").to_stdout
      end

      it 'Checks if the method catch extra parentheses in several lines' do
        expect { test.paren_syn(lines_paren) }
          .to output("\"line:1 extra )\"\n\"line:2 extra (\"\n\"line:3 extra (\"\n").to_stdout
      end

      it 'Checks if the method avoid to catch parentheses in a string and in a regex' do
        expect { test.paren_syn(lines_w_str) }
          .to output("\"line:1 extra )\"\n\"line:4 extra (\"\n").to_stdout
      end
    end
  end

  describe '#curly_syn' do
    let(:test) { Checks.new }

    let(:file) { File.open('curly_test.rb') }

    let(:op_paren) { '{{}' }

    let(:cl_paren) { '}{}' }

    let(:order_paren) { '}{}{' }

    let(:lines_paren) do
      '}{}{
       {{}
       {{{'
    end

    context 'Testing curly_syn method' do
      #it 'Checks if the method read a file' do
      #  expect { test.curly_syn(file) }.to output("\"You have an extra } in line 1\"\n").to_stdout
      #end
#
      #it 'Checks if the method catch an extra opening curly bracket' do
      #  expect { test.curly_syn(op_paren) }.to output("\"You have an extra { in line 1\"\n").to_stdout
      #end
#
      #it 'Checks if the method catch an extra closing curly bracket' do
      #  expect { test.curly_syn(cl_paren) }.to output("\"You have an extra } in line 1\"\n").to_stdout
      #end
#
      #it 'Checks if the method catch a closing curly bracket before an opening curly bracket' do
      #  expect { test.curly_syn(order_paren) }.to output("\"You have an extra } in line 1\"\n").to_stdout
      #end
#
      #it 'Checks if the method catch extra curly brackets in several lines' do
      #  expect { test.curly_syn(lines_paren) }
      #    .to output("\"You have an extra } in line 1\"\n\"You have an extra { in line 2\"\n\"You have an extra { in line 3\"\n").to_stdout
      #end
    end
  end
end
