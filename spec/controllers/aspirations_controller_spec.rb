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

    context '#new' do
        it 'renders view' do
            get :new
            expect(response).to render_template('aspirations/new')
        end

        it 'sets up aspiration model' do
            get :new
            expect(assigns[:aspiration]).to be_a(Aspiration)
        end
    end

    context '#create' do
        context 'with valid params' do
            let(:aspiration_params) do
                {
                    aspiration: {
                        title: 'The name of a new aspiration',
                        description: 'A long description of this new aspiration'
                    }
                }
            end

            it 'does redirect' do
                post :create, params: aspiration_params
                expect(response).to redirect_to(aspirations_path)
            end

            it 'saves aspiration model' do
                post :create, params: aspiration_params
                aspiration = assigns[:aspiration]
                expect(aspiration).to be_a(Aspiration)
                expect(aspiration).to be_persisted
            end

            it 'has info flash message' do
                post :create, params: aspiration_params
                expect(flash[:info]).to eq 'Aspiration created'
            end
        end

        context 'with invalid params' do
            let(:bad_aspiration_params) do
                {
                    aspiration: {
                        title: '',
                        description: ''
                    }
                }
            end

            it 'sets up aspiration but does not save' do
                post :create, params: bad_aspiration_params
                aspiration = assigns[:aspiration]
                expect(aspiration).to be_a(Aspiration)
                expect(aspiration).not_to be_persisted
            end

            it 'shows new aspiration page' do
                post :create, params: bad_aspiration_params
                expect(response).to render_template('aspirations/new')
            end

            it 'has error message for user' do
                post :create, params: bad_aspiration_params
                expect(flash.now[:error]).to eq 'The aspiration was not saved'
            end
        end
    end
end