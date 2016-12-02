class User < ActiveRecord::Base

  validates_presence_of :username, :email, :first_name, :last_name
  validates_uniqueness_of :username, :email

  has_secure_password
end
