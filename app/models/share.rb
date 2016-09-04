class Share < ActiveRecord::Base
  after_create :push_to_firebase

  include SimpleHashtag::Hashtaggable

  validates :body, presence: true
  belongs_to :user, foreign_key: 'user_id', class_name: "User"

  scope :newest, -> {order("updated_at DESC")}
  
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  private

  def push_to_firebase
    response = FIREBASE.push("shares", {
      :title => self.title,
      :body => self.body,
      :lat => self.lat,
      :lon => self.lon 
    })
  end
end
