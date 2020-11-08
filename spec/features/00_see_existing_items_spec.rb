require 'rails_helper'

feature 'Visitor views todo items' do
    scenario 'that are still pending' do
        visit '/todo_items'
        expect(page).to have_content("Todo Items")
    end
end