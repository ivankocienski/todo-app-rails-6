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
end
