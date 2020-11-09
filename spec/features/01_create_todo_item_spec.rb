require 'rails_helper'

feature 'Creating a new item' do
    scenario 'with valid information' do
        visit '/todo_items'
        click_link 'Add New Item...'

        fill_in "Description", with: "This is a new item description"
        click_button "Create Todo item"

        #expect(response).to be_redirect("/todo_items")
        expect(page).to have_selector("ul li", count: 1)
        expect(page).to have_content("This is a new item description")
    end
end