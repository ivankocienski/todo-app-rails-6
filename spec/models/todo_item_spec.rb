require 'rails_helper'

RSpec.describe TodoItem, type: :model do
    context 'basic' do
        let(:todo_list) { FactoryBot.create(:todo_list) }

        it 'is valid' do
            contents = {
                description: 'This',
                todo_list: todo_list
            }

            item = TodoItem.create(contents)
            expect(item).to be_valid
        end

        it 'is invalid' do
            item = TodoItem.create

            expect(item).not_to be_valid
        end
    end

    describe 'associations' do
        it { is_expected.to belong_to(:todo_list) }
    end
end
