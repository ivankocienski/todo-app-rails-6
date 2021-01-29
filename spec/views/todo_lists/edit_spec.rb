require 'rails_helper'

describe 'todo_lists/edit', type: :view do
    let(:todo_list) { FactoryBot.create(:todo_list, title: 'This is a Todo List') }

    before :each do
        assign :todo_list, todo_list
    end

    it 'renders title' do
        render

        expected_title = 'Edit This is a Todo List'
        expect(rendered).to have_selector('h1', text: expected_title)
    end

    context 'with aspirations' do
        let(:aspirations) do
            %i[aspiration aspiration_2 aspiration_3].map do |id|
                FactoryBot.create id
            end
        end

        it 'has aspiration selector' do
            assign :aspirations, aspirations
            render

            list_filter = 'select option'
            expect(rendered).to have_selector(list_filter, count: 4)
        end
    end
end