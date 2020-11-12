require 'rails_helper'

describe "Home controller", type: :routing do
    context 'root' do
        it 'sends request to home root' do
            expect( get: '/').to route_to("home#root")
        end
    end

    context 'about' do
        it 'sends request to home about' do
            expect( get: '/about').to route_to("home#about")
        end
    end
end
