require 'rails_helper'

feature 'Aspirations' do
    it 'can be changed by user' do
        given_an_aspiration_exists

        visit '/'
        click_link 'Aspirations'
        click_link 'Learning German'
        click_link 'Edit'

        fill_in 'Title', with: 'Learning formal German'
        click_button 'Save'

        expect(page).to have_content('Learning formal German')
    end

    def given_an_aspiration_exists
        FactoryBot.create :aspiration
    end
end