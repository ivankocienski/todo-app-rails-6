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
end