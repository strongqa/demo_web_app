require "rails_helper"

RSpec.describe Comment, type: :model do
  describe 'factory' do
    subject { build(:comment).valid?}
    it { is_expected.to eq(true)}
  end
end