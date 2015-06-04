require 'rails_helper'

RSpec.describe User, type: :model do
  describe "should be admin" do
    subject {described_class.new({:email => "admin@strongqa.com"})}
    it {expect(subject.email).to eq(Rails.application.config_for(:admin)['email'])}
  end

  describe "should not be admin" do
    subject {described_class.new}
    it {expect(subject.email).not_to eq(Rails.application.config_for(:admin)['email'])}
  end
end