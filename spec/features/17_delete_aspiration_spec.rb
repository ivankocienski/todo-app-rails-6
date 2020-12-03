require 'rails_helper'

feature 'Aspirations' do
    it 'can be deleted by user' do
        given_an_aspiration_exists

        visit '/'
        click_link 'Aspirations'
        click_link 'Learning German'
        click_link 'Edit'

        click_button 'Delete'

        expect(page).not_to have_content('Learning German')
    end

    def given_an_aspiration_exists
        FactoryBot.create :aspiration
    end
end