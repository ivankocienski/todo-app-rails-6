require 'rails_helper'

describe HomeController, type: :controller do
    context '#root' do
        it 'renders root page' do
            get :root

            expect(response).to be_successful
        end        
    end

    context '#about' do
        it 'renders about page' do
            get :about

            expect(response).to be_successful
        end

        it 'has correct navigation' do
            get :about
            expect(assigns[:navigation]).to eq :about
        end
    end

end