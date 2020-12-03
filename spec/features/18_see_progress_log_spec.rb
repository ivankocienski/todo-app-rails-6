require 'rails_helper'

feature 'Progress' do
    it 'can be seen by user' do
        given_some_progress_logs_exist

        visit '/'
        click_link 'Progress'

        expect(page).to have_content('Saturday 1st January, 2000')
        expect(page).to have_content('Sunday 2nd January, 2000')
        expect(page).to have_content('Monday 3rd January, 2000')
    end

    def given_some_progress_logs_exist
        %i[progress_log progress_log_2 progress_log_3].each do |factory_name|
            FactoryBot.create factory_name
        end
    end
end