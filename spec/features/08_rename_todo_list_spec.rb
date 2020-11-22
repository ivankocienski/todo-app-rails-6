require 'rails_helper'

feature 'Todo Lists' do
    scenario 'I should be able to rename a Todo List' do
        visit '/'

        click_link('Todo Lists')
        click_link('Create New Todo List')

        fill_in 'Title', with: 'This is a new Todo List'
        click_button 'Create'

        # implied 'show' action
        click_link 'This is a new Todo List'
        click_link 'Edit'

        fill_in 'Title', with: 'A renamed Todo List'
        click_button 'Update'

        expect(page).to have_content('A renamed Todo List')
    end
end