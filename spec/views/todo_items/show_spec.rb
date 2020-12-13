require 'rails_helper'

describe 'todo_items/show', type: :view do
    let(:todo_list) { FactoryBot.create(:todo_list) }

    before :each do
        assign :todo_list, todo_list
        assign :item, todo_list.todo_items.new(description: 'This is a todo item')
    end

    it 'has a title' do
        render
        expect(rendered).to have_selector('h1', text: 'This is a todo item')
    end
end