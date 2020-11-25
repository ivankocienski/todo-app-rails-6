require 'rails_helper'

feature 'Creating a new Todo Item on Todo List' do
    # this supercedes 01_create_todo_item

    scenario 'with valid information' do
        given_todo_list_exists

        visit '/todo_lists'
        click_link 'This is todo list'
        click_link 'Add New Item...'

        fill_in 'Description', with: 'This is a new item description on a todo list'
        click_button 'Create Todo item'

        expect(page).to have_selector('ul li', count: 1)
        expect(page).to have_content('This is a new item description on a todo list')
    end

    def given_todo_list_exists
        FactoryBot.create(:todo_list)
    end
end