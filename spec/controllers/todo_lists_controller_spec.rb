require 'rails_helper'

describe TodoListsController, type: :controller do
    context '#index' do
        it 'exists' do
            get :index

            expect(response).to be_successful
        end

        it 'finds Todo Lists' do
            get :index
            expect(assigns[:todo_lists]).not_to be_nil
        end
    end
end