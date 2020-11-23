require 'rails_helper'

describe 'todo_lists/show', type: :view do
    it 'has a title' do
        assign :todo_list, FactoryBot.create(:todo_list, title: 'A todo list title')
        render

        expect(rendered).to have_content('A todo list title')
    end

    context 'todo items' do
        let(:todo_list) { FactoryBot.create(:todo_list, title: 'A todo list title') }

        before :each do
            %i[todo_item todo_item_2 todo_item_3].each do |factory_id|
                FactoryBot.create(factory_id, todo_list: todo_list)
            end
        end

        it 'shows us a list' do
            assign :todo_list, todo_list
            render

            expect(rendered).to have_selector('ul#todo-items li', count: 3)
        end
    end
end
