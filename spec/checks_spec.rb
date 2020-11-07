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

    context 'Testing paren_syn method' do
      it 'Checks if the method read a file' do
        expect { test.paren_syn(file) }.to output("\"You have an extra ) in line 1\"\n").to_stdout
      end

      it 'Checks if the method catch an extra opening parentheses' do
        expect { test.paren_syn(op_paren) }.to output("\"You have an extra ( in line 1\"\n").to_stdout
      end

      it 'Checks if the method catch an extra closing parentheses' do
        expect { test.paren_syn(cl_paren) }.to output("\"You have an extra ) in line 1\"\n").to_stdout
      end

      it 'Checks if the method catch a closing parentheses before an opening parentheses' do
        expect { test.paren_syn(order_paren) }.to output("\"You have an extra ) in line 1\"\n").to_stdout
      end

      it 'Checks if the method catch extra parentheses in several lines' do
        expect { test.paren_syn(lines_paren) }
          .to output
        "\"You have an extra ) in line 1\"\n\"You have an extra ( in line 2\"\n\"You have an extra ( in line 3\"\n"
          .to_stdout
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
    it 'Checks if the method read a file' do
      expect { test.curly_syn(file) }.to output("\"You have an extra } in line 1\"\n").to_stdout
    end

    it 'Checks if the method catch an extra opening parentheses' do
      expect { test.curly_syn(op_paren) }.to output("\"You have an extra { in line 1\"\n").to_stdout
    end

    it 'Checks if the method catch an extra closing parentheses' do
      expect { test.curly_syn(cl_paren) }.to output("\"You have an extra } in line 1\"\n").to_stdout
    end

    it 'Checks if the method catch a closing parentheses before an opening parentheses' do
      expect { test.curly_syn(order_paren) }.to output("\"You have an extra } in line 1\"\n").to_stdout
    end

    it 'Checks if the method catch extra parentheses in several lines' do
      expect { test.curly_syn(lines_paren) }
        .to output
      "\"You have an extra } in line 1\"\n\"You have an extra ( in line 2\"\n\"You have an extra { in line 3\"\n"
        .to_stdout
    end
  end
end
end
