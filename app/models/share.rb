class Share < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :user, foreign_key: 'user_id', class_name: "User"
  has_many :votes
  has_many :comments
  
end
