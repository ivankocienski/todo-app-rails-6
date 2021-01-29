require 'rails_helper'

describe 'todo_lists/new', type: :view do
    before :each do
        assign :todo_list, TodoList.new
    end

    it 'has a title' do
        render
        expect(rendered).to have_selector('h1', text: 'Create New Todo List')
    end

    it 'has form' do
        render

        # form
        form_filter = "form[action='/todo'][method='post']"
        expect(rendered).to have_selector(form_filter)

        # label
        field_label = 'form label'
        expect(rendered).to have_selector(field_label, text: 'Title')

        # field
        field_input = "form input[name='todo_list[title]']"
        expect(rendered).to have_selector(field_input)

        # submit
        submit_filter = "form input[type='submit'][value='Create Todo list']"
        expect(rendered).to have_selector(submit_filter)
    end

    context 'aspirations' do
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