require 'rails_helper'

feature 'Navigation' do
    scenario 'is present and functional' do
        visit '/'
        expect(page).to have_active_nav_link('Home')
        expect(page).to have_link('Todo Items')
        expect(page).to have_link('About')

        click_link('Todo Items')
        expect(page).to have_link('Home')
        expect(page).to have_active_nav_link('Todo Items')
        expect(page).to have_link('About')

        click_link('About')
        expect(page).to have_link('Home')
        expect(page).to have_link('Todo Items')
        expect(page).to have_active_nav_link('About')
    end

    def have_active_nav_link(text)
        have_selector('header nav a[class="active"]', text: text)
    end
end