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

  describe "EDIT comment" do
    it "should allow users to edit comments on shares" do
      comment = FactoryGirl.create(:comment)
      sign_in comment.user
      get :edit, id: comment.id, share_id: comment.share.id
      expect(response).to have_http_status(:success)
    end

    it "should only allow the comment creator to edit the body" do
      comment = FactoryGirl.create(:comment)
      user = FactoryGirl.create(:user)
      sign_in user
      get :edit, id: comment.id, share_id: comment.share.id
      expect(response).to have_http_status(:forbidden)
    end

    it "should not let unauthenticated users edit a comment" do
      comment = FactoryGirl.create(:comment)
      get :edit, id: comment.id, share_id: comment.share.id
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "UPDATE comment" do
    it "should allow users to update comments on shares" do
      comment = FactoryGirl.create(:comment)
      sign_in comment.user
      patch :update, id: comment.id, share_id: comment.share.id, comment: {body: "Updated"}
      expect(response).to redirect_to share_path(comment.share)
    end

    it "should only allow the comment creator to edit the body" do
      comment = FactoryGirl.create(:comment)
      user = FactoryGirl.create(:user)
      sign_in user
      patch :update, id: comment.id, share_id: comment.share.id, comment: {body: "Updated"}
      expect(response).to have_http_status(:forbidden)
    end

    it "should not let unauthenticated users edit a comment" do
      comment = FactoryGirl.create(:comment)
      patch :update, id: comment.id, share_id: comment.share.id, comment: {body: "Updated"}
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "DELETE comment" do
    context "with authenticated users" do

      before do
        request.env["HTTP_REFERER"] = 'http://localhost/'
      end

      it "should allow user to delete a comment" do
        user = FactoryGirl.create(:user)
        share = FactoryGirl.create(:share)
        sign_in user
        post :create, user_id: user.id, share_id: share.id, comment: {body: 'awesome share'}
        delete :destroy, share_id: Share.first.id, id: Comment.first.id
        expect(Comment.count).to eq(0)
      end

      it "should not allow user to delete another users' comment" do
        user = FactoryGirl.create(:user)
        share = FactoryGirl.create(:share)
        sign_in user
        post :create, user_id: user.id, share_id: share.id, comment: {body: 'awesome share'}
        sign_out user
        user2 = FactoryGirl.create(:user)
        sign_in user2
        delete :destroy, share_id: Share.first.id, id: Comment.first.id
        expect(Comment.count).to eq(1)
      end
    end

    context "with unauthenticated users" do
      it "should not allow user to delete any comment" do
        user = FactoryGirl.create(:user)
        share = FactoryGirl.create(:share)
        sign_in user
        post :create, user_id: user.id, share_id: share.id, comment: {body: 'awesome share'}
        sign_out user
        delete :destroy, share_id: Share.first.id, id: Comment.first.id
        expect(Comment.count).to eq(1)
      end
    end
  end
end
