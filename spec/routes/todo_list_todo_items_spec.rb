require 'rails_helper'

describe 'Todo List Todo Items', type: :routing do
    let(:todo_list) { FactoryBot.create(:todo_list) }

    # context 'index' # is part of show todo list

    context 'new' do
        it 'responds with new item action' do
            path = "/todo/#{todo_list.id}/items/new"
            expect(get: path).to route_to('todo_items#new', todo_id: todo_list.id.to_s)
        end
    end

    context 'show' do
        it 'routes to "show" action' do
            path = "/todo/#{todo_list.id}/items/123"
            expect(get: path).to route_to('todo_items#show', id: '123', todo_id: todo_list.id.to_s)
        end
    end

    context 'create' do
        it 'routes to correct action' do
            path = "/todo/#{todo_list.id}/items"
            expect(post: path).to route_to('todo_items#create', todo_id: todo_list.id.to_s)
        end
    end

    context 'edit' do
        it 'routes to "edit" action' do
            path = "/todo/#{todo_list.id}/items/123/edit"
            expect(get: path).to route_to('todo_items#edit', id: '123', todo_id: todo_list.id.to_s)
        end
    end

    context 'update' do
        it 'routes to "update" action' do
            path = "/todo/#{todo_list.id}/items/123"
            expect(put: path).to route_to('todo_items#update', id: '123', todo_id: todo_list.id.to_s)
        end
    end
end
