require 'rails_helper'

feature 'Home Page' do
    it 'has my aspirations' do
        given_my_aspirations_exist

        visit '/'

        expect(page).to have_content('italian cooking')
    end

    def given_my_aspirations_exist
        FactoryBot.create(:aspiration, title: 'italian cooking')
    end
end