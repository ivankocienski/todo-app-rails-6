require 'rails_helper'

feature 'Completing items (on lists)' do
    # this supercedes 02_mark_items_as_done_spec

    scenario 'will show them as complete' do
        given_a_todo_list_exists
        given_some_items_exist

        visit '/'
        click_link 'Todo Lists'
        click_link 'This is todo list'

        click_link 'Alpha alpha alpha'
        click_button 'Mark as Complete'

        expect(page).to have_content('Alpha alpha alpha (done)')
    end

    def given_some_items_exist
        todo_list = TodoList.first
        %i[todo_item todo_item_2 todo_item_3].map do |id| 
            FactoryBot.create(id, todo_list: todo_list) 
        end
    end

    def given_a_todo_list_exists
        FactoryBot.create :todo_list
    end
end