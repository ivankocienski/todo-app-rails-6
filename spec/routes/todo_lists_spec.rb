require 'rails_helper'

describe 'Todo Lists', type: :routing do
    context 'index' do
        it 'triggers items index' do
            expect(get: '/todo/').to route_to('todo_lists#index')
        end
    end

    context 'new' do
        it 'responds with new item action' do
            expect(get: '/todo/new').to route_to('todo_lists#new')
        end
    end

    context 'create' do
        it 'routes to correct action' do
            expect(post: '/todo').to route_to('todo_lists#create')
        end
    end

    context 'show' do
        it 'routes to correct action' do
            expect(get: '/todo/123').to route_to('todo_lists#show', id: '123')
        end
    end

    context 'edit' do
        it 'routes to "edit" action' do
            expect(get: '/todo/123/edit').to route_to('todo_lists#edit', id: '123')
        end
    end

    context 'update' do
        it 'routes to "update" action' do
            expect(put: '/todo/123').to route_to('todo_lists#update', id: '123')
        end
    end

    context 'delete' do
        it 'routes to "delete" action' do
            expect(delete: '/todo/123').to route_to('todo_lists#destroy', id: '123')
        end
    end
end