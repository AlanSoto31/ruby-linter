# rubocop:disable Metrics/BlockLength

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

    let(:ok) { '()' }

    context 'Testing paren_syn method' do
      it 'Checks if the method read a file' do
        expect { test.paren_syn(file) }
          .to output("\e[0;31;49mline:1 Lint/Syntax: unexpected token
        (\e[0m\n\e[0;31;49mline:1 Lint/Syntax: unexpected token )\e[0m\n").to_stdout
      end

      it 'Checks if the method catch an extra opening parentheses' do
        expect { test.paren_syn(op_paren) }
          .to output("\e[0;31;49mline:1 Lint/Syntax: unexpected token (\e[0m\n").to_stdout
      end

      it 'Checks if the method catch an extra closing parentheses' do
        expect { test.paren_syn(cl_paren) }
          .to output("\e[0;31;49mline:1 Lint/Syntax: unexpected token )\e[0m\n").to_stdout
      end

      it 'Checks if the method catch a closing parentheses before an opening parentheses' do
        expect { test.paren_syn(order_paren) }
          .to output("\e[0;31;49mline:1 Lint/Syntax: unexpected token )
          \e[0m\n\e[0;32;49mNo offenses\e[0m\n").to_stdout
      end

      it 'Checks if the method catch extra parentheses in several lines' do
        expect { test.paren_syn(lines_paren) }
          .to output("\e[0;31;49mline:1 Lint/Syntax: unexpected token )\e[0m\n
          \e[0;31;49mline:2 Lint/Syntax: unexpected token (
            \e[0m\n\e[0;31;49mline:3 Lint/Syntax: unexpected token (\e[0m\n").to_stdout
      end

      it 'Checks if the method avoid to catch parentheses in a string and in a regex' do
        expect { test.paren_syn(lines_w_str) }
          .to output("\e[0;31;49mline:1 Lint/Syntax: unexpected token )
          \e[0m\n\e[0;31;49mline:4 Lint/Syntax: unexpected token (\e[0m\n").to_stdout
      end

      it 'Checks if the method works when the is no offenses' do
        expect { test.paren_syn(ok) }.to output("\e[0;32;49mNo offenses\e[0m\n").to_stdout
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
