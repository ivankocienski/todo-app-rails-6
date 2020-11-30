require 'rails_helper'

describe 'todo_items/edit', type: :view do
    let(:item) { FactoryBot.create(:todo_item) }
    let(:todo_list) { FactoryBot.create(:todo_list) }

    before :each do
        assign :todo_list, todo_list
    end

    context 'with pending item' do
        before :each do
            assign :item, item
            render
        end

        it 'renders description' do
            expect(rendered).to have_selector('h1', text: 'This is an item')
        end

        it 'has "complete" button' do
            path = "/todo_lists/#{todo_list.id}/todo_items/#{item.id}"
            form_selector = "form[action='#{path}']"
            expect(rendered).to have_selector(form_selector)

            button_selector = "input[type='submit'][value='Mark as Complete']"
            expect(rendered).to have_selector(button_selector)
        end
    end

    context 'with complete item' do
        before :each do
            item.update! completed: true
            assign :item, item
            render
        end

        it 'does not have "complete" button' do
            form_selector = "form[action='#{todo_list_todo_item_path(todo_list, item)}']"
            expect(rendered).not_to have_selector(form_selector)

            button_selector = "input[type='submit'][value='Mark as Complete']"
            expect(rendered).not_to have_selector(button_selector)
        end
    end

    context 'with missing item' do
        it 'renderes appropriate message' do
            render

            expect(rendered).to have_selector('h1', text: '[Todo Item not found]')
        end
    end
end