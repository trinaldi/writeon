require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:title).of_type(String) }
  it { is_expected.to have_field(:body).of_type(String) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to embed_many(:comment) }

  context 'when new post is created' do
    let(:new_post) { create(:post) }

    it 'will increase Comment count' do
      expect { new_post }.to change { Post.count }.by(1)
    end
  end
end
