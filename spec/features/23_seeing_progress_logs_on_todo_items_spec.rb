require 'rails_helper'

feature 'Todo items' do
    it 'can be visited from progress logs that reference them' do
        given_a_todo_list_exists
        given_a_todo_item_exists
        given_some_progress_logs_exists

        visit '/'
        click_link 'Todo Lists'
        click_link 'This is todo list'
        click_link 'A description of the task to do'

        expect(page).to have_selector('ul#progress_logs li', count: 3)
    end

    def given_a_todo_list_exists
        FactoryBot.create :todo_list
    end

    def given_a_todo_item_exists
        todo_list = TodoList.first
        todo_list.todo_items.create(description: 'A description of the task to do')
    end

    def given_some_progress_logs_exists
        todo_item = TodoItem.first

        %i[progress_log progress_log_2 progress_log_3].each do |progress_log_id|
            progress_log = FactoryBot.create(progress_log_id)
            progress_log.todo_item = todo_item
            progress_log.save!
        end
    end
end