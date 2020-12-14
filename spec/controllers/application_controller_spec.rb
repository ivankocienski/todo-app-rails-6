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

    context '#respond_not_found' do
        controller do
            def index
                respond_not_found nil
            end
        end

        it 'has 404 status' do
            get :index
            expect(response.status).to eq 404
        end

        it 'renders error page' do
            get :index
            expect(response).to render_template('common/404')
        end
    end

    context 'RecordNotFound' do
        controller do
            def index
                # raise ActiveRecord::RecordNotFound
                @progress_log = ProgressLog.find(1234)
            end
        end

        it 'is caught and handled' do
            get :index
            expect(response.status).to eq 404
            expect(response).to render_template('common/404')
        end
    end
end