require 'rails_helper'

describe 'todo_items/edit', type: :view do
    context 'with pending item' do
        it 'renders description' do
            item = FactoryBot.create(:todo_item)
            assign :item, item
            render

            expect(rendered).to have_selector('h1', text: 'This is an item')
        end

        it 'has "complete" button' do
            item = FactoryBot.create(:todo_item)
            assign :item, item
            render

            form_selector = "form[action='#{todo_item_path(item)}']"
            expect(rendered).to have_selector(form_selector)

            button_selector = "input[type='submit'][value='Mark as Complete']"
            expect(rendered).to have_selector(button_selector)
        end
    end

    context 'with complete item' do
        it 'does not have "complete" button' do
            item = FactoryBot.create(:todo_item, completed: true)

            assign :item, item
            render

            form_selector = "form[action='#{todo_item_path(item)}']"
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