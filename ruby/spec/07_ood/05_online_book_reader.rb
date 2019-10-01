class Block
end

class Chapter < Block
end

class Paragraph < Block
end

class Picture < Block
end

class Header < Block
end

class Book
  attr_accessor :titie, :author, :blocks
end

class User
  attr_accessor :books, :bookmarks
end

class Bookmark
  attr_accessor :book, :block, :offset, :user
end
