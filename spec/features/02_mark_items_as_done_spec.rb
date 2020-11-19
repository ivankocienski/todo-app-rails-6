require 'rails_helper'

feature 'Completing items' do
    scenario 'will show them as complete' do
        given_some_items_exist

        visit '/todo_items'

        click_link 'Alpha alpha alpha'
        click_button 'Mark as Complete'

        expect(page).to have_content('Alpha alpha alpha (done)')
    end

    def given_some_items_exist
        %i[todo_item todo_item_2 todo_item_3].map { |id| FactoryBot.create(id) }
    end
end