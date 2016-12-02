class Commitment < ActiveRecord::Base
  belongs_to :committers, class_name: User
  belongs_to :event

  

end
