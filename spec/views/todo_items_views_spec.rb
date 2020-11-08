require 'rails_helper'

describe 'todo_items/index', type: :view do
    it 'has a title' do
        render

        expect(rendered).to have_content("Todo Items")
    end
end