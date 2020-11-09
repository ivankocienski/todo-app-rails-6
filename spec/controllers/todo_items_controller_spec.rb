require 'rails_helper'

describe TodoItemsController, type: :controller do
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
end