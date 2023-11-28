require 'rails_helper'

RSpec.describe Comment do
  describe 'validations' do
    describe 'body' do
      context 'when blank' do
        subject { build(:comment, body: nil) }

        it do
          expect(subject).not_to be_valid
          expect(subject.errors[:body]).to include("can't be blank")
        end
      end
    end

    describe 'user' do
      context 'when blank' do
        subject { build(:comment, user: nil) }

        it do
          expect(subject).not_to be_valid
          expect(subject.errors[:user]).to include('must exist')
        end
      end
    end
  end
end
