require 'rails_helper'

describe 'todo_items/new', type: :view do
    let(:todo_list) { FactoryBot.create(:todo_list) }

    before :each do
        assign :todo_list, todo_list
        assign :item, TodoItem.new
    end

    it 'has a title' do
        render
        expect(rendered).to have_selector('h1', text: 'Add New Todo Item')
    end

    it 'has form' do
        render

        # form
        path = "/todo_lists/#{todo_list.id}/todo_items"
        form_filter = "form[action='#{path}'][method='post']"
        expect(rendered).to have_selector(form_filter)

        # label
        field_label = 'form label'
        expect(rendered).to have_selector(field_label, text: 'Description')

        # field
        field_input = "form input[name='todo_item[description]']"
        expect(rendered).to have_selector(field_input)

        # submit
        submit_filter = "form input[type='submit'][value='Create']"
        expect(rendered).to have_selector(submit_filter)
    end
end