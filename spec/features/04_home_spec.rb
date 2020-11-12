require 'rails_helper'

feature 'Landing page' do
    scenario 'has a title' do
        visit '/'
        expect(page).to have_content('Hello, you')
    end
end

feature 'About page' do
    scenario 'has a title' do
        visit '/'
        click_link 'About'
        expect(page).to have_content('About this app')
    end
end