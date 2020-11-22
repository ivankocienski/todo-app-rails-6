require 'rails_helper'

feature 'Todo Lists' do
    scenario 'I should be able to rename a Todo List' do
        given_a_todo_list_exists

        visit '/'

        click_link 'Todo Lists'
        expect(page).to have_selector('ul#todo-lists li', count: 1)

        click_link 'This is todo list'
        click_link 'Edit'
        click_button 'Delete'

        expect(page).not_to have_content('This is todo list')
        expect(page).not_to have_selector('ul#todo-lists li')
    end

    def given_a_todo_list_exists
        FactoryBot.create(:todo_list)
    end
end