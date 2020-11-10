require '../lib/checks'

describe Checks do
  let(:test) { Checks.new }
  let(:file) { File.open('test_spec.rb') }
  describe '#paren_syn' do
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

    let(:ok_paren) { '()' }

    context 'Testing paren_syn method' do
      it 'Checks if the method read a file' do
        expect(test.paren_syn(file)).to eql({})
      end

      it 'Checks if the method catch an extra opening parentheses' do
        expect(test.paren_syn(op_paren)).to eql({ 1 => '(' })
      end

      it 'Checks if the method catch an extra closing parentheses' do
        expect(test.paren_syn(cl_paren)).to eql({ 1 => ')' })
      end

      it 'Checks if the method catch a closing parentheses before an opening parentheses' do
        expect(test.paren_syn(order_paren)).to eql({ 1 => ')' })
      end

      it 'Checks if the method catch extra parentheses in several lines' do
        expect(test.paren_syn(lines_paren)).to eql({ 1 => ')', 2 => '(', 3 => '(' })
      end

      it 'Checks if the method avoid to catch parentheses in a string and in a regex' do
        expect(test.paren_syn(lines_w_str)).to eql({ 1 => ')', 4 => '(' })
      end
    end
  end

  describe '#doend_syn' do
    context '' do
      let(:ending_keyword) do
        'do
        end
        end'
      end

      let(:starting_keywords) do
        'do
        if
        while
        def
        end'
      end

      it 'Checks if the method read a file' do
        expect(test.doend_syn(file)).to eql({})
      end

      it 'Checks if the method cath an extra end' do
        expect(test.doend_syn(ending_keyword)).to eql({ 3 => 'end' })
      end

      it 'Checks if the method cath extra starting key words' do
        expect(test.doend_syn(starting_keywords)).to eql({ 4 => '(do-if-while-def)' })
      end
    end
  end
end
