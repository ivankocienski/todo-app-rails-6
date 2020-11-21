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

    context '#new' do
        it 'exists' do
            get :new
            expect(response).to be_successful
        end

        it 'sets up new Todo List' do
            get :new
            expect(assigns[:todo_list]).to be_a TodoList
        end
    end

    context '#create' do
        context 'with valid params' do
            let(:create_params) { { title: 'A new todo list' } }

            it 'creates todo list' do
                post :create, params: { todo_list: create_params }

                expect(assigns[:todo_list]).to be_a(TodoList)
                expect(assigns[:todo_list]).to be_persisted
                expect(assigns[:todo_list].title).to eq 'A new todo list'
            end

            it 'does a redirect' do
                post :create, params: { todo_list: create_params }
                expect(response).to redirect_to('/todo_lists')
            end

            it 'sets up flash' do
                post :create, params: { todo_list: create_params }
                expect(flash[:info]).to eq 'Todo List has been created'
            end
        end

        context 'with invalid params' do
            let(:bad_params) { { title: '_' } }

            it 'does not save todo list' do
                post :create, params: { todo_list: bad_params }

                expect(assigns[:todo_list]).not_to be_persisted
            end

            it 'takes you to the "new" page' do
                post :create, params: { todo_list: bad_params }
                expect(response).to render_template('todo_lists/new')
            end

            it 'sets up error flash' do
                post :create, params: { todo_list: bad_params }
                expect(flash.now[:error]).to eq 'Todo List was not saved'
            end
        end
    end
end