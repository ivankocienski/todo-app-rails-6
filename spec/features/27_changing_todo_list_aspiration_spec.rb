require 'rails_helper'

feature 'A Todo List' do
    it 'Can have the aspiration modified' do
        given_a_number_of_aspirations_exists
        given_a_todo_list_exists

        visit '/'
        click_link 'Todo Lists'
        click_link 'This is todo list'

        # original aspiration
        expect(page).to have_content('Learning German')

        click_link 'Edit'
        select 'Being better at art', from: 'Aspiration'
        click_button 'Update'

        # new aspiration
        click_link 'This is todo list'
        expect(page).to have_content('Being better at art')
    end

    def given_a_number_of_aspirations_exists
        FactoryBot.create :aspiration
        FactoryBot.create :aspiration_2
    end

    def given_a_todo_list_exists
        aspiration = Aspiration.where(title: 'Learning German').first
        FactoryBot.create :todo_list, aspiration: aspiration
    end
end