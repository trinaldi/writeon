require 'rails_helper'

RSpec.describe Todo, type: :model do
  it { is_expected.to have_field(:done).of_type(Mongoid::Boolean) }
  it { is_expected.to have_field(:task).of_type(String) }
  it { is_expected.to validate_presence_of(:done) }
  it { is_expected.to validate_presence_of(:task) }
  it { is_expected.to be_embedded_in(:day) }

  it 'defaults done to false' do
    day = create(:day)
    todo = day.todos.build(attributes_for(:todo).except(:done))

    expect(todo.done).to be false
  end

  it 'is invalid without task' do
    day = create(:day)
    todo = day.todos.build(attributes_for(:todo, task: nil))

    expect(todo).not_to be_valid
  end

  it 'can be created through day' do
    day = create(:day)
    todo = day.todos.create!(attributes_for(:todo))

    expect(todo).to be_persisted
  end
end
