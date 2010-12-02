class Friendship < ActiveRecord::Base
  unloadable
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  validates_presence_of :user
  validates_presence_of :friend
  validate :user_differs_from_friend

  private
  def user_differs_from_friend
    errors.add(:friend, "User can't be a friend to himself") if self.user == self.friend
  end
end

