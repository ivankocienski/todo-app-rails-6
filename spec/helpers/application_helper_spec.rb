require 'rails_helper'

describe ApplicationHelper, type: :helper do
    context '#navigation_link' do
        it 'returns link in default mode' do
            link = helper.navigation_link('/about', :about, 'About this site')
            expect(link).to have_selector("a[href='/about']", text: 'About this site')
        end

        it 'returns active link in correct mode' do
            assign :navigation, :about
            link = helper.navigation_link('/about', :about, 'About this site')
            expect(link).to have_selector("a[href='/about'][class='active']", text: 'About this site')
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

    context '#field_hints' do
        before :each do
            FormHints.load_from File.join(Rails.root, '/spec/fixtures/form_hints/some_hints_db.yml')
        end

        it 'returns empty string for missing hint' do
            html = helper.field_hints(:not_mode, :not_field)
            expect(html).to eq ''
        end

        it 'returns correct HTML for present hint' do
            html = helper.field_hints(:sample_model, :sample_field)
            expect(html).to have_selector('div.hints h6', text: 'Hints:')
            expect(html).to have_selector('.hints ul li', count: 3)
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