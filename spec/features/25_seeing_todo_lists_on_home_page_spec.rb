require 'rails_helper'

feature 'Home Page' do
    it 'has my todo lists' do
        given_my_todo_lists_exist

        visit '/'

        expect(page).to have_content('This is todo list')
        expect(page).to have_content('Alpha alpha alpha')
    end

    def given_my_todo_lists_exist
        aspiration = FactoryBot.create(:aspiration)

        %i[todo_list todo_list_2 todo_list_3].each do |factory_id|
            FactoryBot.create factory_id, aspiration: aspiration
        end
    end
end