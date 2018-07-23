require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    before { subject.valid? }

    describe 'body' do
      context 'when blank' do
        subject { build(:comment, body: nil) }
        it { expect(subject.errors[:body]).to include("can't be blank") }
      end
    end

    describe 'user' do
      context 'when blank' do
        subject { build(:comment, user: nil) }
        it { expect(subject.errors[:user]).to include("can't be blank") }
      end
    end
  end
end
