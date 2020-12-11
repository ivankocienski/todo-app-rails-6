require 'rails_helper'

describe 'progress_logs/new', type: :view do
    before :each do
        assign :open_todo_items, []
        assign :progress_log, ProgressLog.new
    end

    it 'has a title' do
        render
        expect(rendered).to have_selector('h1', text: 'Write Progress Log')
    end

    it 'has form' do
        render

        # form
        path = '/progress_logs'
        form_filter = "form[action='#{path}'][method='post']"
        expect(rendered).to have_selector(form_filter)
    end

    it 'has list of todo items to select from' do
        todo_list = FactoryBot.create(:todo_list)
        3.times do |n|
            todo_list.todo_items.create(description: "Open item #{n}")
        end

        assign :open_todo_items, todo_list.todo_items
        render

        expect(rendered).to have_selector('select option', count: 4)
    end
end
