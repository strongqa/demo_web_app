require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#admin?' do
    let(:user) { build(:user, email: email) }
    let(:admin_email) { 'admin@example.com' }
    let(:user_email) { 'user@example.com' }
    subject { user.admin? }
    before { allow(Rails.application).to receive(:config_for).with(:admin) { { 'email' => admin_email } } }

    context 'when admin email' do
      let(:email) { admin_email }
      it { is_expected.to eq(true) }
    end

    context 'when user email' do
      let(:email) { user_email }
      it { is_expected.to eq(false) }
    end
  end
end
