require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:name).of_type(String) }
  it { is_expected.to have_field(:message).of_type(String) }

  context 'when new comment is created' do
    let(:new_comment) { create(:comment) }

    it 'will increase Comment count' do
      expect { new_comment }.to change { Comment.count }.by(1)
    end
  end
end
