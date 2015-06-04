require "rails_helper"

RSpec.describe Article, type: :model do
  describe 'factory' do
    subject { build(:article).valid?}
    it { is_expected.to eq(true)}
  end
end