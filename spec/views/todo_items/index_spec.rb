require 'rails_helper'

describe 'todo_items/index', type: :view do
    it 'has a title' do
        assign :items, []
        render

        expect(rendered).to have_content('Todo Items')
    end

    it 'shows items' do
        assign :items, [
            FactoryBot.create(:todo_item),
            FactoryBot.create(:todo_item_2),
            FactoryBot.create(:todo_item_3)
        ]
        render

        expect(rendered).to have_selector('ul li', count: 3)
    end

    it 'has item links' do
        sole_item = FactoryBot.create(:todo_item)
        assign :items, [sole_item]

        render

        link_selector = "ul li a[href='#{edit_todo_item_path(sole_item)}']"
        expect(rendered).to have_selector(link_selector)
    end

    it 'has "add new" link' do
        assign :items, []
        render

        add_new_selector = "a[@href='/todo_items/new']"
        expect(rendered).to have_selector(add_new_selector, text: 'Add New Item...')
    end

    context 'filter UX' do
        before :each do
            assign :items, []
        end

        context 'when filter is OFF' do
            it 'shows a filter link' do
                assign :filter_items, false
                render

                filter_link_selector = "a[@href='?filter=pending']"
                expect(rendered).to have_selector(filter_link_selector, text: 'Show only pending items')
            end
        end

        context 'when filter is ON' do
            it 'shows a message' do
                assign :filter_items, true
                render

                filter_link_selector = "a[@href='?filter=pending']"
                expect(rendered).not_to have_selector(filter_link_selector)

                expect(rendered).to have_content('Showing only pending items')
            end
        end
    end
end