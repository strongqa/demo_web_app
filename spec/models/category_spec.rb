require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do

    describe 'name' do
      context 'when blank' do
        subject { build(:category, name: nil) }
        it do
          is_expected.to be_invalid
          expect(subject.errors[:name]).to eq(["can't be blank"])
        end
      end
    end
  end
end