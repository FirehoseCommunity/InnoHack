require 'rails_helper'

RSpec.describe SharesController, type: :controller do
	describe "shares#index action" do
		it "should require users to be logged in" do
			get :new
			expect(response).to redirect_to new_user_session_path
		end

		it "should successfully show the page" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

	describe "shares#new action" do
		it "should successfully show the new form" do
			user = FactoryGirl.create(:user)
			sign_in user

			get :new
			expect(response).to have_http_status(:success)
		end
	end

	describe "shares#create action" do
		it "should require users to be logged in" do
			post :create, share: {body: 'Hack Attack!'}
			expect(response).to redirect_to new_user_session_path
		end

		it "should successfully create a new share in our database" do
			user = FactoryGirl.create(:user)
			sign_in user

			post :create, share: {body: 'Hack Attack!'}
			expect(response).to redirect_to shares_path

			share = Share.last
			expect(share.body). to eq("Hack Attack!")
		end

		it "should properly deal with validation errors" do
			user = FactoryGirl.create(:user)
			sign_in user

			post :create, share: {body: ''}
			expect(response).to have_http_status(:unprocessable_entity)
		end
	end

	describe "shares#show action" do
		it "should successfully show a share" do
			share = FactoryGirl.create(:share)
			get :show, id: share.id
		end

		it "should return a 404 error if the gram is not found" do
			get :show, id: 'NOTHING HERE'
			expect(response).to have_http_status(:not_found)
		end
	end
end
