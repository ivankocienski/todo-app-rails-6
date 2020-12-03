require 'rails_helper'

describe 'aspirations/edit', type: :view do
    it 'renders title' do
        assign :aspiration, FactoryBot.create(:aspiration)
        render

        expect(rendered).to have_selector('h1', text: 'Edit Aspiration')
    end

    it 'renders form' do
        assign :aspiration, FactoryBot.create(:aspiration)
        render

        expect(rendered).to have_selector('form')

        field_selector = 'input[type="hidden"][name="_method"][value="patch"]'
        expect(rendered).to have_selector(field_selector, visible: false)
    end
end