require 'rails_helper'

feature 'Creating a new item' do
    scenario 'with valid information' do
        # Todo List being here is a hack. The specs
        #   for Todo Items will be re-written to
        #   explicitly deal with the Todo List
        #   they belong to.
        todo_list = FactoryBot.create(:todo_list)

        visit '/todo_items'
        click_link 'Add New Item...'

        fill_in 'Description', with: 'This is a new item description'
        fill_in 'Todo list', with: todo_list.id
        click_button 'Create Todo item'

        expect(page).to have_selector('ul li', count: 1)
        expect(page).to have_content('This is a new item description')
    end
end