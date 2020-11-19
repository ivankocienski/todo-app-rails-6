require 'rails_helper'

describe 'todo_items/new', type: :view do
    before :each do
        assign :item, TodoItem.new
    end

    it 'has a title' do
        render
        expect(rendered).to have_selector('h1', text: 'Add New Todo Item')
    end

    it 'has form' do
        render

        # form
        form_filter = "form[action='/todo_items'][method='post']"
        expect(rendered).to have_selector(form_filter)

        # label
        field_label = 'form label'
        expect(rendered).to have_selector(field_label, text: 'Description')

        # field
        field_input = "form input[name='todo_item[description]']"
        expect(rendered).to have_selector(field_input)

        # submit
        submit_filter = "form input[type='submit'][value='Create Todo item']"
        expect(rendered).to have_selector(submit_filter)
    end
end