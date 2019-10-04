class Blob
  attr_reader :content # Array or String with data

  def initialize(content)
    @content = content
  end

  def size
    @content&.size || 0
  end
end

class FileItem
  attr_reader :name, :metadata, :blob

  def initialize(name, metadata = {})
    @name = name
    @metadata = metadata
  end

  def write_file(content)
    @blob = Blob.new(content)
    self
  end

  def to_s
    "#{name} #{blob&.size || 0}"
  end
end

class Directroy < FileItem
  attr_reader :files # hash maps name to file

  def initialize(name, metadata = {})
    super
    @files = {}
  end

  def ls(path = '')
    find(path).files.keys.sort
  end

  def find(path = '')
    curr = self

    path.split('/').each do |step|
      curr = curr.files[step]
    end

    curr
  end

  def mk_dir(name)
    files[name] = Directroy.new(name)
  end

  def create_file(name, metadata: {}, content: nil)
    files[name] = FileItem.new(name, metadata).write_file(content)
  end

  def to_s
    name
  end
end

class FileSystem < Directroy
  def initialize
    super('/')
  end
end

RSpec.describe 'FileSystem' do
  let(:file_system) { FileSystem.new }

  it do
    expect(file_system.ls).to eq []

    file_system.create_file('my.txt', content: 'payload')
    my_dir = file_system.mk_dir('my-dir')

    expect(file_system.ls).to eq ['my-dir', 'my.txt']

    my_dir.mk_dir('dir11')
    my_dir.mk_dir('dir12')
    expect(file_system.ls(my_dir.name)).to eq ['dir11', 'dir12']
  end
end
