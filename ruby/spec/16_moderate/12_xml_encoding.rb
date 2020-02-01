class XmlElement
  attr_reader :tag, :attrs, :children, :value

  def initialize(tag, attrs: [], children: [], value: nil)
    @tag = tag
    @attrs = attrs
    @children = children
    @value = value
  end
end

class XmlAttribute
  attr_reader :tag, :value

  def initialize(tag, value)
    @tag = tag
    @value = value
  end
end

# Mistakes, forgotten spaces after tags and values, refactored
def encode_xml(element, res = '', dict = Hash.new { |hash, key| hash[key] = (hash.size + 1).to_s })
  append_value(res, dict[element.tag])

  element.attrs.each do |attr|
    append_value(res, dict[attr.tag])
    append_value(res, attr.value)
  end

  append_value(res, '0')

  if element.value
    append_value(res, element.value)
  else
    element.children.each do |child|
      encode_xml(child, res, dict)
    end
  end

  append_value(res, '0')

  {
    encoded: res,
    dict: dict
  }
end

def append_value(str, value)
  str << value << ' '
end

RSpec.describe 'encode_xml' do
  subject { encode_xml(element) }

  let(:element) do
    XmlElement.new(
      'family',
      attrs: [
        XmlAttribute.new('lastName', 'McDowell'),
        XmlAttribute.new('state', 'CA'),
      ],
      children: [
        XmlElement.new(
          'person',
          attrs: [
            XmlAttribute.new('firstName', 'Gayle'),
          ],
          value: 'Some Message'
        )
      ]
    )
  end

  it do
    is_expected.to be_a Hash

    expect(subject[:dict]).to eq(
      'family' => '1',
      'lastName' => '2',
      'state' => '3',
      'person' => '4',
      'firstName' => '5',
    )

    expect(subject[:encoded]).to eq '1 2 McDowell 3 CA 0 4 5 Gayle 0 Some Message 0 0 '
  end
end
