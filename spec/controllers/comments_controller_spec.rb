require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "comments#create action" do
    it "should allow users to create comments on shares" do
      share = FactoryGirl.create(:share)
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, user_id: user.id, share_id: share.id, comment: {body: 'awesome share'}
      expect(share.comments.length).to eq 1
      expect(share.comments.first.body).to eq "awesome share"
    end

    it "should require a user to be logged in to comment on a share" do
      share = FactoryGirl.create(:share)
      post :create, share_id: share.id, comment: {body: 'awesome share'}
      expect(response).to redirect_to new_user_session_path
    end

    it "should return http status code 404 if the share isn't found" do
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, user_id: user.id, share_id: 'HeMoGloBiN', comment: {body: 'awesome share'}
      expect(response).to have_http_status :not_found
    end
  end
end
