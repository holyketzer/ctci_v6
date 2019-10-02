class User
end

class Friendship
  attr_reader :user1, :user2
end

class Message
  attr_reader :from, :at, :payload
end

class Chat
  attr_reader :users, :messages
end

class Client
  def sign_in(user)
  end

  def sign_out(user)
  end

  def chats(user)
  end

  def set_status(user, status)
  end

  def create_chat(users, name)
  end

  def send_message(chat, message)
  end
end

class Server
  attr_accessor :clients

  def ping(user)
  end
end
