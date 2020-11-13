require 'rails_helper'

describe TodoItemsController, type: :controller do
    context 'navigation' do
        controller do
            def peek_navigation
                render plain: ''
            end
        end

        before :each do
            routes.draw { get "peek_navigation" => "todo_items#peek_navigation" }
        end

        it 'is set up correctly' do
            get :peek_navigation
            expect(assigns[:navigation]).to eq :todo_items
        end
    end

    context 'index' do
        it 'renders index view' do
            get :index
            expect(response).to render_template("todo_items/index")
        end

        it 'finds items' do
            FactoryBot.create :todo_item
            FactoryBot.create :todo_item_2
            FactoryBot.create :todo_item_3

            get :index

            items = assigns[:items]
            expect(items).to be_a(ActiveRecord::Relation)
            expect(items.length).to eq 3
        end

        it 'sets "completed" filter to OFF by default' do
            get :index

            expect(assigns[:filter_items]).to be_a(FalseClass)
        end
        
        it 'can filter out completed items' do
            FactoryBot.create :todo_item
            FactoryBot.create :todo_item_2, completed: true
            FactoryBot.create :todo_item_3

            get :index, { params: { filter: :pending}}

            items = assigns[:items]
            expect(items.length).to eq 2

            expect(assigns[:filter_items]).to be_truthy
        end
    end

    context 'new' do
        it 'renders new view' do
            get :new
            expect(response).to render_template("todo_items/new")
        end

        it 'sets up an Item' do
            get :new
            expect(assigns[:item]).to be_a(TodoItem)
        end
    end

    context 'edit' do
        context 'with existing item' do

            let(:existing_item) { FactoryBot.create(:todo_item) }
        
            it 'renders edit view' do
                get :edit, { params: { id: existing_item.id }}
                expect(response).to render_template("todo_items/edit")
            end

            it 'sets up an Item' do
                get :edit, { params: { id: existing_item.id }}

                expect(assigns[:item]).to eq(existing_item)
            end
        end

        context 'with bad item ID' do
            it 'fails gracefully' do
                get :edit, { params: { id: 123 }}
                expect(response.status).to eq 404
            end

            it 'has message' do
                get :edit, { params: { id: 123 }}
                expect(flash.now[:error]).to eq 'Todo Item not found'
            end
        end
    end

    context 'create' do
        context 'with valid fields' do
            let(:new_item_params) {{ description: "This is a description" }}

            it 'creates an item' do
                post :create, params: { todo_item: new_item_params }

                expect(assigns[:item]).to be_a(TodoItem)
                expect(assigns[:item]).to be_persisted
                expect(assigns[:item].description).to eq 'This is a description'
            end

            it 'does redirect' do
                post :create, params: { todo_item: new_item_params }

                expect(response).to redirect_to("/todo_items")
            end
        end

        context 'with missing fields' do
            it 'renders New action' do
                post :create, params: { todo_item: { description: "" }}

                expect(response).to render_template("todo_items/new")
            end
        end
    end

    context 'update' do
        context 'with valid item ID' do
            it 'marks item as completed' do
                existing_item = FactoryBot.create(:todo_item)
                put :update, params: { id: existing_item.id }

                existing_item.reload
                expect(existing_item.completed).to be true
            end

            it 'redirects with message' do
                existing_item = FactoryBot.create(:todo_item)
                put :update, params: { id: existing_item.id }

                expect(response).to redirect_to(todo_items_path)
                expect(flash[:info]).to eq 'Item marked as completed'
            end
        end

        context 'with invalid item ID' do
            it 'redirects with message' do
                put :update, params: { id: '1234' }

                expect(response).to redirect_to(todo_items_path)
                expect(flash[:error]).to eq 'Todo Item with that ID could not be found'
            end
        end
    end
end