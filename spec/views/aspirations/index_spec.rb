require 'rails_helper'

RSpec.describe 'aspirations/index.html.erb', type: :view do
    context 'title' do
        it 'is present' do
            assign :aspirations, []
            render
            expect(render).to have_selector('h1', text: 'Your Aspirations')
        end
    end

    context 'aspirations' do
        it 'are seen by visitor' do
            assign :aspirations, [
                FactoryBot.build(:aspiration),
                FactoryBot.build(:aspiration_2),
                FactoryBot.build(:aspiration_3)
            ]
            render
            expect(render).to have_selector('ul#aspirations li', count: 3)
        end
    end
end
