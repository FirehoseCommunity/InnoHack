FactoryGirl.define do
	factory :user do
		sequence :email do |n|
	  		"dummyEmail#{n}@gmail.com"
		end
		password "secretPassword"
		password_confirmation "secretPassword"

	end

  factory :share do 
    body "Hack Attack!"
    association :user
  end

end