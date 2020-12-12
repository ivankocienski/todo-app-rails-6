require 'rails_helper'

feature 'Progress log' do
    let(:long_description) do
        'I have worked on this nugget. It was a hard job to do but gosh darn it I kept at it.'
    end

    it 'can be viewed' do
        given_a_todo_list_exists
        given_a_todo_item_exists
        given_a_progress_log_exists

        visit '/'
        click_link 'Progress'
        click_link 'Saturday 1st January, 2000'

        expect(page).to have_selector('h1', text: 'Saturday 1st January, 2000')

        todo_item = TodoItem.first
        href = todo_list_todo_item_path(todo_item.todo_list, todo_item)
        expect(page).to have_selector("a[href='#{href}']", text: 'A description of the task to do')
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