require 'rails_helper'

feature 'Aspirations' do
    it 'Can delete their associated todo lists' do
        given_an_aspiration_with_todo_lists_exists

        visit '/'
        click_link 'Todo Lists'

        expect(page).to have_selector('ul#todo-lists li', count: 3)

        click_link 'Aspirations'
        click_link 'Learning German'
        click_link 'Edit'
        check 'Delete Todo lists as well'
        click_button 'Delete'

        click_link 'Todo Lists'
        expect(page).not_to have_selector('ul#todo-lists li')
    end

    def given_an_aspiration_with_todo_lists_exists
        aspiration = FactoryBot.create :aspiration
        %i[todo_list todo_list_2 todo_list_3].each do |id|
            FactoryBot.create id, aspiration: aspiration
        end
    end
end