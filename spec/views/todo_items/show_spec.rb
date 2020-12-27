require 'rails_helper'

describe 'todo_items/show', type: :view do
    let(:todo_list) { FactoryBot.create(:todo_list) }
    let(:todo_item) { todo_list.todo_items.create(description: 'This is a todo item') }

    before :each do
        assign :todo_list, todo_list
        assign :item, todo_item
        assign :progress_logs, []
    end

    it 'has a title' do
        render
        expect(rendered).to have_selector('h1', text: 'This is a todo item')
    end

    it 'has link to todo list' do
        render
        path = todo_path(todo_list)
        expect(rendered).to have_selector("a[href='#{path}']", text: 'This is todo list')
    end

    context 'progress logs' do
        let(:progress_logs) do
            %i[progress_log progress_log_2 progress_log_3].map do |progress_log_id|
                FactoryBot.create(progress_log_id, todo_item: todo_item)
            end
        end

        it 'shown when present' do
            assign :progress_logs, progress_logs
            render

            expect(rendered).to have_selector('ul#progress_logs li', count: 3)
        end

        it 'skipped when empty' do
            render
            expect(rendered).not_to have_selector('ul#progress_logs')
        end
    end
end