require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:title).of_type(String) }
  it { is_expected.to have_field(:body).of_type(String) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to embed_many(:comment) }
end
