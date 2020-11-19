require 'rails_helper'

feature 'Todo Lists' do
    scenario 'When I go to the site I should be able to see my Todo Lists' do
        visit '/'

        click_link('Todo Lists')
        
        expect(page).to have_content("Your Todo Lists")
    end
end