require 'rails_helper'

feature 'Aspirations' do
    it 'can be seen by user' do
        given_some_aspirations_exist

        visit '/'
        click_link 'Aspirations'

        expect(page).to have_content('Learning German')
        expect(page).to have_content('Being better at art')
        expect(page).to have_content('Build robot')
    end

    def given_some_aspirations_exist
        %i[aspiration aspiration_2 aspiration_3].each do |factory_name|
            FactoryBot.create factory_name
        end
    end
end