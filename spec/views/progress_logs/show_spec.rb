require 'rails_helper'

describe 'progress_logs/show', type: :view do
    let(:progress_log) { FactoryBot.create(:progress_log) }

    before :each do
        assign :progress_log, progress_log
    end

    it 'has a title' do
        render
        expect(rendered).to have_selector('h1', text: 'Saturday 1st January, 2000')
    end

    it 'has a todo_item link when set' do
        todo_item = FactoryBot.create(:todo_item)
        progress_log.todo_item = todo_item
        progress_log.save!

        render

        href = todo_list_todo_item_path(todo_item.todo_list, todo_item)
        expect(rendered).to have_selector("a[href='#{href}']", text: 'This is an item')
    end
end
