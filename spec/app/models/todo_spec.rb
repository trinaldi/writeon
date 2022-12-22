require 'rails_helper'

RSpec.describe Todo, type: :model do
  it { is_expected.to have_field(:done).of_type(Mongoid::Boolean) }
  it { is_expected.to have_field(:task).of_type(String) }
  it { is_expected.to validate_presence_of(:done) }
  it { is_expected.to validate_presence_of(:task) }
end
