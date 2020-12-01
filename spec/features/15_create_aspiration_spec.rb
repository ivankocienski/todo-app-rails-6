require 'rails_helper'

feature 'Aspirations' do
    it 'can be created by user' do
        visit '/'
        click_link 'Aspirations'
        click_link 'Add Aspiration'

        fill_in 'Title', with: 'This is a new aspiration'
        fill_in 'Description', with: 'A longer note about this aspiration here'
        click_button 'Create'

        expect(page).to have_content('This is a new aspiration')
    end
end