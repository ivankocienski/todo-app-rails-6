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

    context 'aspiration' do
        context 'when not set' do
            it 'saves okay' do
                params = {
                    title: 'A description of the progress that was done today in long form'
                }

                todo_list = TodoList.create(params)
                expect(todo_list).to be_valid
            end
        end

        context 'when set' do
            let(:aspiration) { FactoryBot.create(:aspiration) }

            context 'with valid aspiration' do
                it 'is okay' do
                    params = {
                        title: 'A description of the progress that was done today in long form',
                        aspiration_id: aspiration.id
                    }

                    todo_list = TodoList.create(params)
                    expect(todo_list).to be_valid
                end
            end

            context 'with invalid aspiration' do
                it 'is not okay' do
                    params = {
                        title: 'A description of the progress that was done today in long form',
                        aspiration_id: 1234
                    }

                    todo_list = TodoList.create(params)
                    expect(todo_list).not_to be_valid
                end
            end
        end
    end
end
