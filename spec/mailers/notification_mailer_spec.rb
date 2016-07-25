require "rails_helper"

RSpec.describe NotificationMailer, type: :mailer do
  describe 'comment_added' do
    #let(:user) { mock_model User, name: 'Lucas', email: 'lucas@email.com' }
    #let(:mail) { described_class.instructions(user).deliver_now }
    share = FactoryGirl.create(:share)
    comment = FactoryGirl.create(:comment, share_id: share.id)
    mail = described_class.comment_added(comment).deliver_now

    it 'renders the subject' do
      expect(mail.subject).to eq('A comment has been added to ')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([share.user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no-reply@innohack.com'])
    end
  end
end
