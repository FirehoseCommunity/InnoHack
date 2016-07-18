class Share < ActiveRecord::Base
  
  belongs_to :user, foreign_key: 'user_id', class_name: "User"
  has_many :votes
  
end
