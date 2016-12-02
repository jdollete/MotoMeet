class Commitment < ActiveRecord::Base
  belongs_to :commiters, class_name: User
  belongs_to :event

end
