require 'rails_helper'

RSpec.describe Mood, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to be_embedded_in(:post) }
end
