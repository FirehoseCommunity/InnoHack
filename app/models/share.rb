class Share < ActiveRecord::Base

  include SimpleHashtag::Hashtaggable

  validates :body, presence: true
  belongs_to :user, foreign_key: 'user_id', class_name: "User"

  scope :newest, -> {order("updated_at DESC")}
  
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

end
