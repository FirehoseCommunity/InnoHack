class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Gravtastic for gravatar support: https://github.com/chrislloyd/gravtastic
  include Gravtastic
  gravtastic

  has_many :shares
  has_many :comments

end
