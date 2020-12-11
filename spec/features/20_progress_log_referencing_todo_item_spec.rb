require 'rails_helper'

feature 'Progress' do
    let(:long_description) do
        'I have worked on this nugget. It was a hard job to do but gosh darn it I kept at it.'
    end

    it 'can be linked to todo_item' do
        given_a_todo_list_exists
        given_a_todo_item_exists

        visit '/'
        click_link 'Progress'
        click_link 'Write progress log'

        fill_in 'Description', with: long_description
        select 'A description of the task to do', from: 'Todo item'
        click_button 'Save'

        expect(page).to have_selector('h1', text: 'Progress Logs')
        expect(page).to have_selector('ul#progress-logs li', count: 1)

        # this *should* take us to show?
        # expect(page).to have_content('Progress has been logged!')
    end

    def given_a_todo_list_exists
        FactoryBot.create :todo_list
    end

    def given_a_todo_item_exists
        todo_list = TodoList.first
        todo_list.todo_items.create(description: 'A description of the task to do')
    end
end