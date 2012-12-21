class Micropost < ActiveRecord::Base
  attr_accessible :content # , :user_id  #nb:if user_id accessible, then anyone can change id on a post 

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  belongs_to :user

  default_scope order: 'microposts.created_at DESC'
end
