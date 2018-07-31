require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    describe 'title' do
      context 'when blank' do
        subject { build(:article, title: nil) }
        it do
          is_expected.to be_invalid
          expect(subject.errors[:title]).to eq(["can't be blank"])
        end
      end

      context 'when less than 5 characters' do
        subject { build(:article, title: 'name') }
        it do
          is_expected.to be_invalid
          expect(subject.errors[:title]).to eq(['is too short (minimum is 5 characters)'])
        end
      end
    end

    describe 'category' do
      context 'when blank' do
        subject { build(:article, category: nil) }
        it do
          is_expected.to be_invalid
          expect(subject.errors[:category]).to eq(['must exist'])
        end
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
    context 'when articles with tag exist' do
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
    context 'when article with some tags' do
      let(:tag1) { create(:tag, name: 'tag1')}
      let(:tag2) { create(:tag, name: 'tag2')}
      let(:article) { create(:article, tags: [tag1, tag2]) }
      subject { article.tag_list }

      it { is_expected.to eq('tag1, tag2') }
    end

    context 'when article without tags' do
      let(:article) { create(:article) }
      subject { article.tag_list }

      it { is_expected.to be_empty }
    end

    context 'when another article exists' do
      let(:article) { create(:article, :with_tags) }
      let(:other_article) { create(:article, :with_tags) }
      subject { article.tag_list }

      it 'does not assign tags to another article' do
        is_expected.not_to include other_article.tag_list
      end
    end
  end

  describe '#tag_list=' do
    context 'when already assigned tag is not duplicated in article' do
      let(:tag1) { create(:tag, name: 'tag1')}
      let(:tag2) { create(:tag, name: 'tag2')}
      let(:article) { create(:article, tags: [tag1, tag2]) }
      subject do
        article.tag_list='tag2'
        article.tag_list
      end

      it { is_expected.to eq 'tag1, tag2' }
    end

    context 'when new tag is assigned to article' do
      let(:tag1) { create(:tag, name: 'tag1')}
      let(:tag2) { create(:tag, name: 'tag2')}
      let(:article) { create(:article, tags: [tag1, tag2]) }
      subject do
        article.tag_list='new_tag'
        article.tag_list
      end

      it { is_expected.to eq 'tag1, tag2, new_tag' }
    end
  end
end
