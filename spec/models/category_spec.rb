require 'rails_helper'

RSpec.describe Category do
  describe 'validations' do
    describe 'name' do
      context 'when blank' do
        subject { build(:category, name: nil) }

        it do
          expect(subject).not_to be_valid
          expect(subject.errors[:name]).to eq(["can't be blank"])
        end
      end
    end
  end
end
