require 'rails_helper'

feature 'Progress' do
    it 'can be created by user' do
        given_date_stubbed_to 2000, 1, 10
        given_some_progress_logs_exist

        visit '/'
        click_link 'Progress'
        click_link 'Write progress log'

        fill_in 'Description', with: 'This is a long description of the work that was done today.'
        click_button 'Save'

        expect(page).to have_content('Monday 10th January, 2000')
        expect(page).to have_content('Saturday 1st January, 2000')
        expect(page).to have_content('Sunday 2nd January, 2000')
        expect(page).to have_content('Monday 3rd January, 2000')
    end

    def given_some_progress_logs_exist
        %i[progress_log progress_log_2 progress_log_3].each do |factory_name|
            FactoryBot.create factory_name
        end
    end

    def given_date_stubbed_to(year, month, day)
        allow(DateTime).to receive(:new).and_return(DateTime.new(year, month, day, 0, 0, 0))
    end
end