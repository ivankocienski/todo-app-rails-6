require 'rails_helper'

describe TodoItemsController, type: :controller do
    let(:todo_list) { FactoryBot.create(:todo_list) }
    let(:todo_item) { FactoryBot.create(:todo_item, todo_list: todo_list) }

    context '#find_todo_list_from_param' do
        controller do
            def index
                render plain: ''
            end
        end

        context 'with valid todo_list ID' do
            it 'sets up @todo_list object' do
                get :index, params: { todo_list_id: todo_list.id }
                expect(assigns[:todo_list]).to be_a(TodoList)
            end
        end

        context 'with invalid todo_list ID' do
            it 'responds with appropriate status code' do
                get :index, params: { todo_list_id: 123 }
                expect(response.status).to eq 404
            end
        end
    end

    context '#find_todo_item_from_param' do
        controller do
            def show
                render plain: ''
            end
        end

        context 'with valid todo_item ID' do
            it 'sets up @item object' do
                get :show, params: { todo_list_id: todo_list.id, id: todo_item.id }
                expect(assigns[:item]).to be_a(TodoItem)
            end
        end

        context 'with invalid todo_item ID' do
            it 'responds with appropriate status code' do
                get :show, params: { todo_list_id: todo_list.id, id: 123 }
                expect(response.status).to eq 404
            end
        end
    end

    context 'navigation' do
        controller do
            def peek_navigation
                render plain: ''
            end
        end

        before :each do
            routes.draw { get 'peek_navigation' => 'todo_items#peek_navigation' }
        end

        it 'is set up correctly' do
            get :peek_navigation, params: { todo_list_id: todo_list.id }
            expect(assigns[:navigation]).to eq :todo_lists
        end
    end

    context 'index' do
        # this functionality is in the 'todo_lists#show' action
    end

    context 'show' do
        before :each do
            get :show, { params: { id: todo_item.id, todo_list_id: todo_list.id } }
        end

        it 'renders show view' do
            expect(response).to render_template('todo_items/show')
        end

        it 'sets up an Item' do
            expect(assigns[:item]).to be_a(TodoItem)
        end

        it 'sets up progress logs' do
            expect(assigns[:progress_logs]).to be_a(ActiveRecord::Relation)
        end
    end

    context 'new' do
        it 'renders new view' do
            get :new, params: { todo_list_id: todo_list.id }
            expect(response).to render_template('todo_items/new')
        end

        it 'sets up an Item' do
            get :new, params: { todo_list_id: todo_list.id }
            expect(assigns[:item]).to be_a(TodoItem)
        end
    end

    context 'edit' do
        before :each do
            get :edit, { params: { todo_list_id: todo_list.id, id: todo_item.id } }
        end

        it 'renders edit view' do
            expect(response).to render_template('todo_items/edit')
        end
    end

    context 'create' do
        context 'with valid fields' do
            let(:new_item_params) do
                {
                    description: 'This is a description'
                }
            end

            it 'creates an item' do
                post :create, params: { todo_list_id: todo_list.id, todo_item: new_item_params }

                expect(assigns[:item]).to be_a(TodoItem)
                expect(assigns[:item]).to be_persisted
                expect(assigns[:item].description).to eq 'This is a description'
            end

            it 'does redirect' do
                post :create, params: { todo_list_id: todo_list.id, todo_item: new_item_params }
                expect(response).to redirect_to("/todo_lists/#{todo_list.id}")
            end
        end

        context 'with missing fields' do
            it 'renders New action' do
                post :create, params: { todo_list_id: todo_list.id, todo_item: { description: '' } }
                expect(response).to render_template('todo_items/new')
            end
        end
    end

    context 'update' do
        it 'marks item as completed' do
            put :update, params: { todo_list_id: todo_list.id, id: todo_item.id }

            todo_item.reload
            expect(todo_item.completed).to be true
        end

        it 'redirects with message' do
            put :update, params: { todo_list_id: todo_list.id, id: todo_item.id }

            expect(response).to redirect_to(todo_list_path(todo_list))
            expect(flash[:info]).to eq 'Item marked as completed'
        end
    end
end
