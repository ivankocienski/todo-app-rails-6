require 'rails_helper'

describe TodoItemsController, type: :controller do
    context 'index' do
        it 'renders index view' do
            get :index
            expect(response).to render_template("todo_items/index")
        end
    end
end