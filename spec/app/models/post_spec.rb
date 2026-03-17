require 'rails_helper'

RSpec.describe Post, type: :model do
  before { Rails.cache.clear }

  it 'invalidates cache when a post is created' do
    Rails.cache.write('all_posts', ['cached_data'])
    expect(Rails.cache.exist?('all_posts')).to be true
    create(:post)
    expect(Rails.cache.exist?('all_posts')).to be false
  end

  it 'invalidates cache when a post is updated' do
    new_post = create(:post, { title: 'Before Update' })
    Rails.cache.write('all_posts', ['cached_data'])
    new_post.update!(title: 'Edit Me!')
    expect(Rails.cache.exist?('all_posts')).to be false
  end

  it 'invalidates cache when a post is destroyed' do
    new_post = create(:post)
    Rails.cache.write('all_posts', ['cached_data'])
    new_post.destroy
    expect(Rails.cache.exist?('all_posts')).to be false
  end

  it 'returns cached posts without hitting the database' do
    cached = [{ 'title' => 'cached post' }]
    Rails.cache.write('all_posts', cached)
    expect(Post).not_to receive(:all)
    result = Rails.cache.fetch('all_posts') { Post.all.to_a }
    expect(result).to eq(cached)
  end

  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:title).of_type(String) }
  it { is_expected.to have_field(:body).of_type(String) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to embed_many(:comments) }
  it { is_expected.to embed_many(:todos) }
  it { is_expected.to embed_one(:mood) }
end
