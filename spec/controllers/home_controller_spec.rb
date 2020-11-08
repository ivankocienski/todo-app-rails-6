require 'rails_helper'

describe HomeController, type: :controller do
    context '#root' do
        it 'renders root page' do
            get :root

            expect(response).to be_successful
        end
    end
end