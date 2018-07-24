require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    before { subject.valid? }
    describe 'title' do
      context 'when blank' do
        subject { build(:article, title: nil) }
        it { expect(subject.errors[:title]).to include("can't be blank") }
      end

      context 'when less than 5 characters' do
        subject { build(:article, title: 'name') }
        it { expect(subject.errors[:title]).to eq(['is too short (minimum is 5 characters)']) }
      end
    end

    describe 'category' do
      context 'when blank' do
        subject { build(:article, category: nil) }
        it { expect(subject.errors[:category]).to eq(["can't be blank"]) }
      end
    end
  end

  describe 'scopes' do
    describe '.ordered' do
      let!(:older_article) { create(:article, created_at: 23.days.ago) }
      let!(:newer_article) { create(:article, created_at: 1.days.ago) }
      subject { described_class.ordered.to_a }

      it 'orders by descending created date' do
        is_expected.to eq [newer_article, older_article]
      end
    end
  end

  describe '.tagged_with' do
    context 'when articles with tag exists' do
      let!(:tag) { create(:tag, :with_articles, name: 'foo') }
      subject { described_class.tagged_with('foo') }

      it { is_expected.to eq(tag.articles) }
    end

    context 'when tagged article does not exist' do
      subject { described_class.tagged_with('foo') }
      it { expect { subject }.to raise_error(/Couldn't find Tag/) }
    end
  end

  describe '#tag_list' do
    context 'tag list be joined with "," and include all tags names' do
      let(:article) { create(:article, :with_tags) }
      let(:article_tags) { article.tags.map(&:name).join(', ') }
      subject { article.tag_list }

      it { is_expected.to eq article_tags }
    end

    context 'other article tags is not included in the tag list' do
      let(:article) { create(:article, :with_tags) }
      let(:other_article) { create(:article, :with_tags) }
      subject { article.tag_list }

      it { is_expected.not_to include other_article.tag_list }
    end
  end

  describe '#tag_list=' do
    let(:article) { create(:article, :with_tags) }
    subject { article.tag_list='tag-1-, new_tag_1' }

    it('expect new tag will be added in list end') do
      is_expected.to eq 'tag-1-, new_tag_1'
    end
  end
end
