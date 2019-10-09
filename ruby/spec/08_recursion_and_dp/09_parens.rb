def parens(n)
  if n == 1
    ['()']
  else
    parens(n - 1).flat_map do |item|
      res = ['()' + item, '(' + item + ')']

      if !parens_couple_seq?(item)
        res << item + '()'
      end

      res
    end
  end
end

def parens_couple_seq?(str)
  if str.size % 2 == 0
    (0..(str.size - 1)).step(2).all? do |i|
      str[i] == '(' && str[i + 1] == ')'
    end
  else
    false
  end
end

RSpec.describe 'parens' do
  subject { parens(n).sort }

  context 'n = 1' do
    let(:n) { 1 }

    it { is_expected.to eq ['()'] }
  end

  context 'n = 2' do
    let(:n) { 2 }

    it { is_expected.to eq ['(())', '()()'] }
  end

  context 'n = 3' do
    let(:n) { 3 }

    it { is_expected.to eq ['((()))', '(()())', '(())()', '()(())', '()()()'] }
  end
end
