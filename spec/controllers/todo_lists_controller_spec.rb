require 'rails_helper'

describe TodoListsController, type: :controller do

    context '#index' do
        it 'exists' do
            get :index

            expect(response).to be_successful
        end
    end
end