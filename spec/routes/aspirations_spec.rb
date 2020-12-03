require 'rails_helper'

describe 'Aspirations', type: :routing do
    context 'index' do
        it 'triggers aspirations index' do
            expect(get: '/aspirations').to route_to('aspirations#index')
        end
    end

    context 'new' do
        it 'responds with new item action' do
            expect(get: '/aspirations/new').to route_to('aspirations#new')
        end
    end

    context 'create' do
        it 'routes to correct action' do
            expect(post: '/aspirations').to route_to('aspirations#create')
        end
    end

    context 'show' do
        it 'routes to correct action' do
            expect(get: '/aspirations/123').to route_to('aspirations#show', id: '123')
        end
    end

    context 'edit' do
        it 'routes to "edit" action' do
            expect(get: '/aspirations/123/edit').to route_to('aspirations#edit', id: '123')
        end
    end

    context 'update' do
        it 'routes to "update" action' do
            expect(patch: '/aspirations/123').to route_to('aspirations#update', id: '123')
        end
    end

    #
    #     context 'delete' do
    #         it 'routes to "delete" action' do
    #             expect(delete: '/todo_lists/123').to route_to('todo_lists#destroy', id: '123')
    #         end
    #     end
end