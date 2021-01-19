require 'rails_helper'

describe HomeController, type: :controller do
    context '#root' do
        before :each do
            get :root
        end

        it 'renders root page' do
            expect(response).to be_successful
        end

        it 'sets up aspirations' do
            expect(assigns[:aspirations]).to be_a(ActiveRecord::Relation)
        end

        it 'sets up todo_lists' do
            expect(assigns[:todo_lists]).to be_a(ActiveRecord::Relation)
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