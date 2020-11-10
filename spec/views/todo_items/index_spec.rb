require 'rails_helper'

describe 'todo_items/index', type: :view do
    it 'has a title' do
        assign :items, []
        render

        expect(rendered).to have_content("Todo Items")
    end

    it 'shows items' do
        assign :items, [
            FactoryBot.create(:todo_item),
            FactoryBot.create(:todo_item_2),
            FactoryBot.create(:todo_item_3)
        ]
        render 

        expect(rendered).to have_selector("ul li", count: 3)
    end

    it 'has item links' do
        sole_item = FactoryBot.create(:todo_item)
        assign :items, [ sole_item ]
        
        render 

        link_selector = "ul li a[href='#{edit_todo_item_path(sole_item)}']"
        expect(rendered).to have_selector(link_selector)
    end

    it 'has "add new" link' do
        assign :items, []
        render
        
        add_new_selector = "a[@href='/todo_items/new']"
        expect(rendered).to have_selector(add_new_selector, text: "Add New Item...")
    end
end