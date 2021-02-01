require 'rails_helper'

describe 'aspirations/edit', type: :view do
    let(:aspiration) { FactoryBot.create(:aspiration) }

    before :each do
        assign :todo_count, 0
        assign :aspiration, aspiration
    end

    it 'renders title' do
        render
        expect(rendered).to have_selector('h1', text: 'Edit Aspiration')
    end

    it 'renders form' do
        render

        expect(rendered).to have_selector('form#edit_aspiration')

        field_selector = 'input[type="hidden"][name="_method"][value="patch"]'
        expect(rendered).to have_selector(field_selector, visible: false)
    end

    context 'delete button' do
        it 'has delete button' do
            render

            delete_button_selector = 'form#delete_aspiration input[type="submit"][value="Delete"]'
            expect(rendered).to have_selector(delete_button_selector)

            field_selector = 'input[type="hidden"][name="_method"][value="delete"]'
            expect(rendered).to have_selector(field_selector, visible: false)
        end

        context 'with non-empty todo lists' do
            before :each do
                %i[todo_list todo_list_2 todo_list_3].each do |id|
                    FactoryBot.create id, aspiration: aspiration
                end

                assign :todo_count, 3
            end

            it 'has warning' do
                render

                warning = 'This aspiration has 3 Todo lists associated with it.'
                expect(rendered).to have_content(warning)
            end

            it 'has prompt to also delete todo lists' do
                render

                checkbox_filter = 'form#delete_aspiration input[type="checkbox"][name="delete_all_todo_lists"]'
                expect(rendered).to have_selector(checkbox_filter)
            end
        end
    end
end