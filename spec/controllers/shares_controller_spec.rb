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

   it "should return a 404 error if the share is not found" do
    get :show, id: 'NOTHING HERE'
    expect(response).to have_http_status(:not_found)
   end 
  end

  describe "shares#edit" do
   it "shouldn't let a user who did not create the share edit a share" do
    share = FactoryGirl.create(:share)
    user = FactoryGirl.create(:user)
    sign_in user

    get :edit, id: share.id
    expect(response).to have_http_status(:forbidden)     
   end

   it "shouldn't let unauthenticated users edit a share" do
    share = FactoryGirl.create(:share)
    get :edit, id: share.id
    expect(response).to redirect_to new_user_session_path
   end

   it "should successfully show the edit form if the share is found" do
    share = FactoryGirl.create(:share)
    sign_in share.user
    get :edit, id: share.id
    expect(response).to have_http_status(:success)
   end

   it "should return a 404 error message if the share is not found" do
    user = FactoryGirl.create(:user)
    sign_in user
    get :edit, id: 'NOT FOUND'
    expect(response).to have_http_status(:not_found)
   end
  end

  describe "shares#update" do
   it "shouldn't let users who did create the share update it" do
    share = FactoryGirl.create(:share)
    user = FactoryGirl.create(:user)
    sign_in user
    patch :update, id: share.id, share: {body: 'Hacked'}
    expect(response).to have_http_status(:forbidden)
   end	

   it "shouldn't let unauthenticated users create a share" do
    share = FactoryGirl.create(:share)
    patch :update, id: share.id, share: {body: 'Hack Attack'}
    expect(response).to redirect_to new_user_session_path
   end

   it "should allow users to successfully update shares" do
    share = FactoryGirl.create(:share, body: "Initial Value")
    sign_in share.user
    patch :update, id: share.id, share: {body: "Updated"}
    expect(response).to redirect_to shares_path
   end

   it "should have http 404 error if the share cannot be found" do
    user = FactoryGirl.create(:user)
    sign_in user
    patch :update, id: "DOES NOT EXIST", share: {body: "Updated"}
    expect(response).to have_http_status(:not_found)
   end

   it "should render the edit form with an http status of unprocessable_entity" do 
    share = FactoryGirl.create(:share, body: "Initial Value")
    sign_in share.user
    patch :update, id: share.id, share: {body: '' }
    expect(response).to have_http_status(:unprocessable_entity)
   end
  end

  describe "shares#destroy" do
   it "shouldn't allow user who did not create the share to destroy it" do
    share = FactoryGirl.create(:share)
    user = FactoryGirl.create(:user)
    sign_in user
    delete :destroy, id: share.id
    expect(response).to have_http_status(:forbidden)
   end

   it "shouldn't let unauthenticated users destroy a share" do
    share = FactoryGirl.create(:share)
    delete :destroy, id: share.id
    expect(response).to redirect_to new_user_session_path
   end

   it "should allow a user to destroy shares" do
    share = FactoryGirl.create(:share)
    sign_in share.user
    delete :destroy, id: share.id
    expect(response).to redirect_to shares_path
   end
   
   it "should allow an admin to destroy shares" do
    share = FactoryGirl.create(:share)
    admin = User.where("admin = true")
    sign_in admin
    delete :destroy, id: share.id
    expect(response).to redirect_to shares_path
   end

   it "should return a 404 message if we cannot find a share with the id specified" do
    user = FactoryGirl.create(:user)
    sign_in user
    delete :destroy, id: 'SHARE IS NOT HERE'
    expect(response).to have_http_status(:not_found)
   end
  end

end
