require 'rails_helper'

describe 'Progress Logs', type: :routing do
    context 'index' do
        it 'triggers items index' do
            expect(get: '/progress_logs/').to route_to('progress_logs#index')
        end
    end

    #    context 'new' do
    #        it 'responds with new item action' do
    #            expect(get: '/progress_logs/new').to route_to('progress_logs#new')
    #        end
    #    end

    #    context 'create' do
    #        it 'routes to correct action' do
    #            expect(post: '/progress_logs').to route_to('progress_logs#create')
    #        end
    #    end

    #    context 'show' do
    #        it 'routes to correct action' do
    #            expect(get: '/progress_logs/123').to route_to('progress_logs#show', id: '123')
    #        end
    #    end
end