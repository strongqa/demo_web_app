require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    describe 'body' do
      context 'when blank' do
        subject { build(:comment, body: nil) }
        it do
          is_expected.to be_invalid
          expect(subject.errors[:body]).to include("can't be blank")
        end
      end
    end

    describe 'user' do
      context 'when blank' do
        subject { build(:comment, user: nil) }
        it do
          is_expected.to be_invalid
          expect(subject.errors[:user]).to include("must exist")
        end
      end
    end
  end
end
