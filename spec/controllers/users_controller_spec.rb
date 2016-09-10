require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "users#update" do
    it "should allow users to update theme" do
      user = FactoryGirl.create(:user)
      sign_in user
      patch :update, id: user.id, user: {theme: "theme1"}
      expect(response).to redirect_to user_path
    end
  end

end
