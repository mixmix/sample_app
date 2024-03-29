class Micropost < ActiveRecord::Base
  attr_accessible :content # , :user_id  #nb:if user_id accessible, then anyone can change id on a post 

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  belongs_to :user

  default_scope order: 'microposts.created_at DESC'

  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)                  #? what would happen if this didn't have self. ? 
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id" 
    where("user_id IN (:followed_user_ids) OR user_id = :user_id", followed_user_ids: followed_user_ids, user_id: user)
  end

#  def self.from_users_followed_by(user)
#    followed_user_ids = user.followed_user_ids
#    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
#  end

end
