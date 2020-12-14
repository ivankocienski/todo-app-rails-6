require 'rails_helper'

describe TodoListsController, type: :controller do
    let(:todo_list) { FactoryBot.create(:todo_list) }

    context 'navigation' do
        controller do
            def peek_navigation
                render plain: ''
            end
        end

        before :each do
            routes.draw { get 'peek_navigation' => 'todo_lists#peek_navigation' }
        end

        it 'is set up correctly' do
            get :peek_navigation
            expect(assigns[:navigation]).to eq :todo_lists
        end
    end

    context 'finding the todo_list record' do
        controller do
            before_action :find_todo_list

            def show
                render plain: ''
            end
        end

        context 'when it exists' do
            it 'finds a todo list' do
                get :show, params: { id: todo_list.id }
                expect(assigns[:todo_list]).to be_a(TodoList)
            end
        end

        context 'when it does not exist' do
            it 'responds with correct error code' do
                get :show, params: { id: 123 }
                expect(response.status).to eq 404
            end
        end
    end

    context '#index' do
        it 'exists' do
            get :index
            expect(response).to be_successful
        end

        it 'finds Todo Lists' do
            get :index
            expect(assigns[:todo_lists]).to be_a(ActiveRecord::Relation)
        end
    end

    context '#show' do
        context 'with todo items' do
            before :each do
                items = {
                    todo_item: false,
                    todo_item_2: true,  # completed
                    todo_item_3: false
                }

                items.each do |name, complete|
                    FactoryBot.create(name, completed: complete, todo_list: todo_list)
                end
            end

            it 'finds items' do
                get :show, params: { id: todo_list.id }

                items = assigns[:todo_items]
                expect(items).to be_a(ActiveRecord::Relation)
                expect(items.length).to eq 3
            end

            it 'sets "pending items only" filter to OFF by default' do
                get :show, params: { id: todo_list.id }
                expect(assigns[:show_only_pending]).to be_a(FalseClass)
            end

            it 'can filter out completed items' do
                get :show, { params: { filter: :pending, id: todo_list.id } }

                items = assigns[:todo_items]
                expect(items.length).to eq 2

                expect(assigns[:show_only_pending]).to be_truthy
            end
        end
    end

    context '#edit' do
        it 'sets up a todo list' do
            get :edit, params: { id: todo_list.id }
            expect(assigns[:todo_list]).to eq todo_list
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

    context '#update' do
        context 'with valid params' do
            let(:todo_params) { { title: 'A modified Todo List title' } }

            it 'updates item' do
                put :update, params: { id: todo_list.id, todo_list: todo_params }

                todo_list = assigns[:todo_list]
                expect(todo_list).to be_a(TodoList)
                expect(todo_list.title).to eq 'A modified Todo List title'
            end

            it 'redirects with message' do
                put :update, params: { id: todo_list.id, todo_list: todo_params }

                expect(response).to redirect_to('/todo_lists')
                expect(flash[:info]).to eq 'Todo List updated successfully'
            end
        end

        context 'with invalid params' do
            let(:todo_params) { { title: '' } }

            it 'takes user to edit page with error' do
                put :update, params: { id: todo_list.id, todo_list: todo_params }

                expect(response).to render_template('todo_lists/edit')
                expect(flash.now[:error]).to eq 'Todo List failed to update'
            end
        end
    end

    context '#destroy' do
        it 'deletes item' do
            todo_list # create before expect block

            expect do
                delete :destroy, params: { id: todo_list.id }
            end.to change(TodoList, :count).by(-1)
        end

        it 'redirects with feedback message' do
            delete :destroy, params: { id: todo_list.id }

            expect(response).to redirect_to('/todo_lists')
            expect(flash[:info]).to eq 'Todo List has been deleted'
        end
    end
end