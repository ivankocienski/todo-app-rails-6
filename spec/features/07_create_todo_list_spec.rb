require 'rails_helper'

feature 'Todo Lists' do
    scenario 'I should be able to add a new Todo List' do
        visit '/'

        click_link('Todo Lists')
        click_link('Create New Todo List')

        fill_in 'Title', with: 'This is a new Todo List'
        click_button 'Create'

        expect(page).to have_content('This is a new Todo List')
    end
end