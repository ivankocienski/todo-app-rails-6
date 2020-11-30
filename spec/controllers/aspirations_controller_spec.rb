require 'rails_helper'

describe AspirationsController, type: :controller do
    context '#index' do
        it 'exists' do
            get :index
            expect(response).to be_successful
        end

        it 'finds Aspirations' do
            get :index
            expect(assigns[:aspirations]).not_to be_nil
        end
    end
end