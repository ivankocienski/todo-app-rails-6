require 'rails_helper'

describe TodoItemsController, type: :controller do
    context 'with non existent Todo List parent' do
        controller do
            def index
                render plain: ''
            end
        end

        it 'redirects to todo_list_show with message' do
            get :index, params: { todo_list_id: 123 }

            expect(flash[:error]).to eq 'Could not find Todo List with that ID'
            expect(response).to redirect_to(todo_lists_path)
        end
    end

    context 'with Todo List parent' do
        let(:todo_list) { FactoryBot.create(:todo_list) }

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

        context 'sets up Todo List object' do
            controller do
                def peek_todo_list
                    render plain: ''
                end
            end

            before :each do
                routes.draw { get 'peek_todo_list' => 'todo_items#peek_todo_list' }
            end

            it 'is set up correctly' do
                get :peek_todo_list, params: { todo_list_id: todo_list.id }
                expect(assigns[:todo_list]).to eq todo_list
            end
        end

        context 'index' do
            # this functionality is in the 'show todo items' controller
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
            context 'with existing item' do
                let(:existing_item) { FactoryBot.create(:todo_item) }

                it 'renders edit view' do
                    get :edit, { params: { id: existing_item.id, todo_list_id: todo_list.id } }
                    expect(response).to render_template('todo_items/edit')
                end

                it 'sets up an Item' do
                    get :edit, { params: { id: existing_item.id, todo_list_id: todo_list.id } }

                    expect(assigns[:item]).to eq(existing_item)
                end
            end

            context 'with bad item ID' do
                it 'fails gracefully' do
                    get :edit, { params: { id: 123, todo_list_id: todo_list.id } }
                    expect(response.status).to eq 404
                end

                it 'has message' do
                    get :edit, { params: { id: 123, todo_list_id: todo_list.id } }
                    expect(flash.now[:error]).to eq 'Todo Item not found'
                end
            end
        end

        context 'create' do
            context 'with valid fields' do
                let(:todo_list) { FactoryBot.create(:todo_list) }
                let(:new_item_params) do
                    {
                        description: 'This is a description'
                    }
                end

                it 'creates an item' do
                    post :create, params: { todo_item: new_item_params, todo_list_id: todo_list.id }

                    expect(assigns[:item]).to be_a(TodoItem)
                    expect(assigns[:item]).to be_persisted
                    expect(assigns[:item].description).to eq 'This is a description'
                end

                it 'does redirect' do
                    post :create, params: { todo_item: new_item_params, todo_list_id: todo_list.id }

                    expect(response).to redirect_to("/todo_lists/#{todo_list.id}")
                end
            end

            context 'with missing fields' do
                it 'renders New action' do
                    post :create, params: { todo_item: { description: '' }, todo_list_id: todo_list.id }

                    expect(response).to render_template('todo_items/new')
                end
            end
        end

        context 'update' do
            context 'with valid item ID' do
                it 'marks item as completed' do
                    existing_item = FactoryBot.create(:todo_item)
                    put :update, params: { id: existing_item.id, todo_list_id: todo_list.id }

                    existing_item.reload
                    expect(existing_item.completed).to be true
                end

                it 'redirects with message' do
                    existing_item = FactoryBot.create(:todo_item)
                    put :update, params: { id: existing_item.id, todo_list_id: todo_list.id }

                    expect(response).to redirect_to(todo_list_path(todo_list))
                    expect(flash[:info]).to eq 'Item marked as completed'
                end
            end

            context 'with invalid item ID' do
                it 'redirects with message' do
                    put :update, params: { id: '1234', todo_list_id: todo_list.id }

                    expect(response).to redirect_to(todo_list_path(todo_list))
                    expect(flash[:error]).to eq 'Todo Item with that ID could not be found'
                end
            end
        end
    end # context 'with Todo List parent'
end
