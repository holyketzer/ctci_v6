RSpec.describe 'number swapper' do
  it do
    a = 10
    b = -55

    a = a - b
    b = a + b
    a = b - a

    expect(a).to eq -55
    expect(b).to eq 10
  end
end
