require 'rails_helper'

describe 'home/root', type: :view do
    before :each do
        assign :aspirations, []
        assign :todo_lists, []
    end

    it 'has a title' do
        render
        expect(rendered).to have_content('Hello, you')
    end

    context 'with aspirations' do
        let(:aspirations) do
            %i[aspiration aspiration_2 aspiration_3]
                .map { |aspiration_name| FactoryBot.create(aspiration_name) }
        end

        it 'renders aspirations' do
            assign :aspirations, aspirations
            render
            expect(rendered).to have_selector('ul#aspirations li', count: 3)
        end
    end

    context 'with todo lists' do
        let(:todo_lists) do
            %i[todo_list todo_list_2 todo_list_3]
                .map { |todo_list_name| FactoryBot.create(todo_list_name) }
        end

        it 'renders aspirations' do
            assign :todo_lists, todo_lists
            render
            expect(rendered).to have_selector('ul#todo-lists li', count: 3)
        end
    end
end