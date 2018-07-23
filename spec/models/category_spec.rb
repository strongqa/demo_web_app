require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    before { subject.valid? }

    describe 'name' do
      context 'when blank' do
        subject { build(:category, name: nil) }
        it { expect(subject.errors[:name]).to include("can't be blank") }
      end
    end
  end
end