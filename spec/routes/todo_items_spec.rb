require 'rails_helper'

describe "Todo Items", type: :routing do
    context 'index' do
        it 'triggers items index' do
            expect( get: '/todo_items/').to route_to("todo_items#index")
        end
    end

    context 'new' do
        it 'responds with new item action' do
            expect( get: '/todo_items/new').to route_to("todo_items#new")
        end
    end

    context 'create' do
        it 'routes to correct action' do
            expect( post: '/todo_items').to route_to("todo_items#create")
        end        
    end

    context 'edit' do
        it 'routes to "edit" action' do
            expect( get: '/todo_items/123/edit').to route_to("todo_items#edit", id: "123")
        end
    end

    context 'update' do
        it 'routes to "update" action' do
            expect( put: '/todo_items/123').to route_to("todo_items#update", id: "123")
        end
    end
end
