class Share < ActiveRecord::Base
  
  include SimpleHashtag::Hashtaggable

  validates :body, presence: true
  belongs_to :user, foreign_key: 'user_id', class_name: "User"
  has_many :votes
  has_many :comments
  
end
