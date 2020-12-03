require 'rails_helper'

RSpec.describe 'aspirations/show.html.erb', type: :view do
    context 'title' do
        let(:aspiration) { FactoryBot.create(:aspiration) }

        it 'is present' do
            assign :aspiration, aspiration
            render
            expect(render).to have_selector('h1', text: 'Learning German')
        end
    end
end
