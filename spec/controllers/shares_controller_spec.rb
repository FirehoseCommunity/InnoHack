require 'rails_helper'

RSpec.describe SharesController, type: :controller do
	describe "shares#index action" do
		it "should successfully show the page" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

	describe "shares#new action" do
		it "should successfully show the new form" do
			get :new
			expect(response).to have_http_status(:success)
		end
	end

	describe "shares#create action" do
		it "should successfully create a new share in our database" do
			post :create, share: {body: 'Hack Attack!'}
			expect(response).to redirect_to shares_path

			share = Share.last
			expect(share.body). to eq("Hack Attack!")
		end
	end
end
