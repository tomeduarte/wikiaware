class Notification < ActiveRecord::Base
  belongs_to :subscription

  validates_presence_of :description
end
