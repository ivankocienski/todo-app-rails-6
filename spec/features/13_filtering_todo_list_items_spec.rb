require 'rails_helper'

feature 'Filtering items' do
    # this supercedes 03_pending_items_filter_spec

    scenario 'will show only items that are outstanding' do
        given_todo_list_with_some_items_exist

        visit '/'
        click_link 'Todo Lists'
        click_link 'This is todo list'
        expect(page).to have_selector('ul li', count: 3)

        click_link 'Show only pending items'
        expect(page).to have_selector('ul li', count: 2)
    end

    def given_todo_list_with_some_items_exist
        todo_list = FactoryBot.create(:todo_list)

        items = {
            todo_item: false,
            todo_item_2: true,  # completed
            todo_item_3: false
        }

        items.map do |name, complete| 
            FactoryBot.create(name, completed: complete, todo_list: todo_list) 
        end
    end
end