class Event < ActiveRecord::Base
  belongs_to :user
  has_many :commitments
  has_many :committers, through: :commitments, source: :committers

  validates_presence_of :title, :body, :address, :starts_at

  def self.upcoming
    current_time = DateTime.current
    where("starts_at >= ?", current_time)
  end

  def self.previous
    current_time = DateTime.current
    where("starts_at < ?", current_time)
  end

end
