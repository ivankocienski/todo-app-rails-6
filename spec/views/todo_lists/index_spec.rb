require 'rails_helper'

describe 'todo_lists/index', type: :view do
    it 'has a title' do
        assign :todo_lists, []
        render

        expect(rendered).to have_content('Todo Lists')
    end

    it 'has a list of todo lists' do
        assign :todo_lists, [
            FactoryBot.create(:todo_list),
            FactoryBot.create(:todo_list_2),
            FactoryBot.create(:todo_list_3)
        ]
        render

        expect(rendered).to have_selector('ul#todo-lists li', count: 3)
    end
end
