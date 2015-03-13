require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :comments
  belongs_to :businesses

  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end

  def authenticate(entered_password)
    self.password == entered_password
  end
end