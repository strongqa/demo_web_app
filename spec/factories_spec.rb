require 'rails_helper'

RSpec.describe 'Factory Bot' do
  FactoryBot.factories.each do |factory|
    describe "#{factory.name} factory" do
      # Test each factory
      it 'is valid' do
        object = build(factory.name)
        expect(object).to be_valid, -> { object.errors.full_messages.join("\n") } if object.respond_to?(:valid?)
      end

      # Test each trait
      factory.definition.defined_traits.map(&:name).each do |trait_name|
        context "with trait #{trait_name}" do
          it 'is valid' do
            object = build(factory.name, trait_name)
            expect(object).to be_valid, -> { object.errors.full_messages.join("\n") } if object.respond_to?(:valid?)
          end
        end
      end
    end
  end
end
