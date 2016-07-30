require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

 describe "About Page" do
   it "should successfully show the page" do
    get :about
    expect(response).to have_http_status(:success)
   end
  end

end