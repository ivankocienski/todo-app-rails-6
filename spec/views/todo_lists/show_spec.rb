require 'rails_helper'

describe 'todo_lists/show', type: :view do
    it 'has a title' do
        assign :todo_list, FactoryBot.create(:todo_list, title: 'A todo list title')
        render

        expect(rendered).to have_content('A todo list title')
    end
end
