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
end