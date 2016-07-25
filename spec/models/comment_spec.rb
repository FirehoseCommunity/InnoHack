require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'sends an email' do
    comment = FactoryGirl.create(:comment)
    expect { comment.send_comment_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
