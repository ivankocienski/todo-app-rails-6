require 'rails_helper'

feature 'Visitor views todo items' do
    scenario 'that exist' do
        given_some_items_exist

        visit '/todo_items'
        expect(page).to have_selector('ul li', count: 3)
    end

    def given_some_items_exist
        %i{ todo_item todo_item_2 todo_item_3 }.map { |id| FactoryBot.create(id) }
    end
end