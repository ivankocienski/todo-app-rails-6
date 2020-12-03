require 'rails_helper'

describe 'aspirations/new', type: :view do
    before :each do
        assign :aspiration, Aspiration.new
        render
    end

    it 'has a title' do
        expect(rendered).to have_selector('h1')
    end

    it 'has form' do
        # form
        form_filter = "form[action='/aspirations'][method='post']"
        expect(rendered).to have_selector(form_filter)
    end
end