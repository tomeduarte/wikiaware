class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :page, :class_name => 'WikiPage'
end
