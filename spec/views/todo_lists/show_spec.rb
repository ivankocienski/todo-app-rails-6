require 'rails_helper'

describe 'todo_lists/show', type: :view do
    let(:todo_list) { FactoryBot.create(:todo_list) }

    before :each do
        assign :todo_list, todo_list
    end

    it 'has a title' do
        assign :todo_items, []
        render

        expect(rendered).to have_content('This is todo list')
    end

    context 'with todo items' do
        before :each do
            %i[todo_item todo_item_2 todo_item_3].each do |factory_id|
                FactoryBot.create(factory_id, todo_list: todo_list)
            end

            assign :todo_items, todo_list.todo_items
        end

        it 'shows us a list' do
            render
            expect(rendered).to have_selector('ul#todo-items li', count: 3)
        end

        context 'with associated aspiration' do
            let(:aspiration) { FactoryBot.create :aspiration }

            it 'is shown' do
                todo_list.aspiration = aspiration
                render
                expect(rendered).to have_content('Learning German')
            end
        end

        context 'with item filter' do
            it 'renders filter link when not set' do
                render
                expect(rendered).to have_selector('a', text: 'Show only pending items')
            end

            it 'does not render filter link when set' do
                assign :show_only_pending, true
                render

                expect(rendered).not_to have_selector('a', text: 'Show only pending items')
                expect(rendered).to have_content('Showing only pending items')
            end
        end
    end
end
