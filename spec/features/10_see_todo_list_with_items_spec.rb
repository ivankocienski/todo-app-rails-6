require 'rails_helper'

feature 'Todo Lists' do
    scenario 'I should be able to rename a Todo List' do
        given_a_todo_list_with_items_exists

        visit '/'

        click_link 'Todo Lists'

        click_link 'This is todo list'

        expect(page).to have_content('This is an item')
        expect(page).to have_selector('ul#todo-items li', count: 3)
    end

    def given_a_todo_list_with_items_exists
        todo_list = FactoryBot.create(:todo_list)

        %i[todo_item todo_item_2 todo_item_3].each do |factory_id|
            FactoryBot.create(factory_id, todo_list: todo_list)
        end
    end
end