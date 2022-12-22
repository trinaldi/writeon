require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:name).of_type(String) }
  it { is_expected.to have_field(:message).of_type(String) }
  it { is_expected.to be_embedded_in(:post) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:message) }
end
