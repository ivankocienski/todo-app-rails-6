require 'rails_helper'

RSpec.describe 'aspirations/show.html.erb', type: :view do
    let(:aspiration) { FactoryBot.create(:aspiration) }

    context 'title' do
        it 'is present' do
            assign :aspiration, aspiration
            render
            expect(render).to have_selector('h1', text: 'Learning German')
        end
    end

    context 'aspiration with associated todo lists' do
        it 'shows list of links' do
            %i[todo_list todo_list_2 todo_list_3].each do |id|
                FactoryBot.create id, aspiration: aspiration
            end

            assign :aspiration, aspiration
            render
            expect(render).to have_selector('ul#todo-lists li', count: 3)
        end
    end
end
