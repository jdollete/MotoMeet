class User < ActiveRecord::Base
  has_many :events
  has_many :commitments, class_name: Commitment

  validates_presence_of :username, :email, :first_name, :last_name
  validates_uniqueness_of :username, :email

  has_secure_password
end
