require 'rails_helper'

feature 'Todo items' do
    it 'can be visited from progress logs that reference them' do
        given_a_todo_list_exists
        given_a_todo_item_exists
        given_a_progress_log_exists

        visit '/'
        click_link 'Progress'
        click_link 'Saturday 1st January, 2000'

        click_link 'A description of the task to do'

        expect(page).to have_selector('h1', text: 'A description of the task to do')
    end

    def given_a_todo_list_exists
        FactoryBot.create :todo_list
    end

    def given_a_todo_item_exists
        todo_list = TodoList.first
        todo_list.todo_items.create(description: 'A description of the task to do')
    end

    def given_a_progress_log_exists
        progress_log = FactoryBot.create(:progress_log)
        progress_log.todo_item = TodoItem.first
        progress_log.save!
    end
end