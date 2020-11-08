require 'rails_helper'

describe "Todo Items", type: :routing do
    context 'index' do
        it 'triggers items index' do
            expect( get: '/todo_items/').to route_to("todo_items#index")
        end
    end
end
