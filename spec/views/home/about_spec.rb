require 'rails_helper'

describe 'home/about', type: :view do
    it 'has a title' do
        render

        expect(rendered).to have_content('About this app')
    end
end