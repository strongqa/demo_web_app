require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#admin?' do
    subject { user.admin? }
    context 'when is_admin true' do
      let(:user) { build(:user, is_admin: true) }
      it { is_expected.to eq(true) }
    end

    context 'when is_admin false' do
      let(:user) { build(:user, is_admin: false) }
      it { is_expected.to eq(false) }
    end

    context 'when is_admin default' do
      let(:user) { build(:user, is_admin: false) }
      it { is_expected.to eq(false) }
    end
  end
end
