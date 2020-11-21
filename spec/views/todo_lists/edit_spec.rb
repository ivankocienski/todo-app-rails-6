require 'rails_helper'

describe 'todo_lists/edit', type: :view do
    it 'renders title' do
        list = FactoryBot.create(:todo_list, title: 'This is a Todo List')
        assign :todo_list, list
        render

        expected_title = 'Edit This is a Todo List'
        expect(rendered).to have_selector('h1', text: expected_title)
    end
end