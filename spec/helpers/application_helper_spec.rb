require 'rails_helper'

describe ApplicationHelper, type: :helper do
    context '#navigation_link' do
        it 'returns link in default mode' do
            link = helper.navigation_link('/path_to_thing', :path_to_thing, 'Path to thing')
            expect(link).to have_selector("a[href='/path_to_thing']", text: 'Path to thing')
        end

        it 'returns active link in correct mode' do
            assign :navigation, :path_to_thing
            link = helper.navigation_link('/path_to_thing', :path_to_thing, 'Path to thing')
            expect(link).to have_selector("a[href='/path_to_thing'][class='active']", text: 'Path to thing')
        end
    end

    context '#field_errors_for' do
        it 'returns blank when no errors present' do
            todo_list = FactoryBot.build(:todo_list)
            html = helper.field_errors_for(todo_list, :title)
            expect(html).to be_empty
        end

        it 'describes errors when present' do
            todo_list = TodoList.new(title: '')
            todo_list.validate

            html = helper.field_errors_for(todo_list, :title)
            expect(html).to have_selector('ul.field-errors li')
        end
    end

    context '#render_flash' do
        it 'returns nothing when empty' do
            html = helper.render_flash({})
            expect(html).to be_empty
        end

        it 'has error when set' do
            flash = { error: 'A problem occurred' }
            html = helper.render_flash(flash)
            expect(html).to have_selector('#flash-box #flash-error.flash', text: 'A problem occurred')
        end
    end
end