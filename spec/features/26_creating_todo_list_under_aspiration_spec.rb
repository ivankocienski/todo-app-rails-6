require 'rails_helper'

feature 'A Todo List' do
    it 'Can be created with an Aspiration parent' do
        given_an_aspiration_exists

        visit '/'
        click_link 'Todo Lists'
        click_link 'Create New Todo List'

        fill_in 'Title', with: 'This is a new Todo List'
        select 'Learning German', from: 'Aspiration'
        click_button 'Create'

        click_link 'This is a new Todo List'

        expect(page).to have_selector('h1', text: 'This is a new Todo List')
        expect(page).to have_content('Learning German')
    end

    def given_an_aspiration_exists
        FactoryBot.create :aspiration
    end
end