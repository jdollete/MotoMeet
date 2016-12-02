class Event < ActiveRecord::Base
  belongs_to :user
  has_many :commitments
  has_many :committers, through :commitments, source: :committers

  validates_presence_of :title, :body, :address, :starts_at

end
