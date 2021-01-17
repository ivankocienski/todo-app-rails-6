require 'rails_helper'

RSpec.describe TodoList, type: :model do
    context 'creating' do
        it 'is missing name' do
            model = TodoList.new
            expect(model).not_to be_valid
        end

        it 'is valid with name' do
            model = TodoList.new(title: 'My first Todo List')
            expect(model).to be_valid
        end
    end

    describe 'associations' do
        it { is_expected.to have_many(:todo_items).dependent(:destroy) }
        it { is_expected.to belong_to(:aspiration).required(false) }
    end
end
