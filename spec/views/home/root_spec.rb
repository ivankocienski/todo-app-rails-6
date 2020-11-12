require 'rails_helper'

describe 'home/root', type: :view do
    it 'has a title' do
        render

        expect(rendered).to have_content("Hello, you")
    end
end