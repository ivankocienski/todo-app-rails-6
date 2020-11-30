require 'rails_helper'

feature 'Filtering items' do
    scenario 'will show only items that are outstanding' do
        given_some_items_exist

        visit '/todo_items'
        expect(page).to have_selector('ul li', count: 3)

        click_link 'Show only pending items'
        expect(page).to have_selector('ul li', count: 2)
    end

    def given_some_items_exist
        items = {
            todo_item: false,
            todo_item_2: true,  # completed
            todo_item_3: false
        }

        items.map { |name, complete| FactoryBot.create(name, completed: complete) }
    end
end