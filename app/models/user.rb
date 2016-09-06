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

  THEMES = {
    'theme 1' => '/images/theme_1.png',
    'theme 2' => '/images/theme_2.png',
    'theme 3' => '/images/theme_3.png'
  }
end
