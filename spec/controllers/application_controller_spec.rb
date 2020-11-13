require 'rails_helper'

describe ApplicationController, type: :controller do
    context 'navigation' do

        controller do
            def index
                render plain: ''
            end
        end

        it 'sets up default navigation' do
            get :index

            expect(assigns[:navigation]).to eq :home
        end
    end
end