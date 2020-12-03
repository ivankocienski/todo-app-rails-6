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

    context '#show' do
        it 'shows aspiration' do
            aspiration = FactoryBot.create(:aspiration)
            get :show, params: { id: aspiration.id }
            expect(response).to render_template('aspirations/show')
        end
    end

    context '#edit' do
        it 'shows aspiration edit page' do
            aspiration = FactoryBot.create(:aspiration)
            get :edit, params: { id: aspiration.id }
            expect(response).to render_template('aspirations/edit')
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

    context '#update' do
        let(:aspiration) { FactoryBot.create(:aspiration) }

        context 'with valid parameters' do
            it 'redirects to show' do
                aspiration_params = {
                    title: 'title'
                }
                put :update, params: { id: aspiration.id, aspiration: aspiration_params }
                expect(response).to redirect_to(aspiration_path(aspiration.id))
            end

            it 'updates fields' do
                aspiration_params = {
                    title: 'This is the new title',
                    description: 'This is the new description of the updated aspiration.'
                }
                put :update, params: { id: aspiration, aspiration: aspiration_params }

                aspiration = assigns[:aspiration]
                expect(aspiration).to be_a(Aspiration)
                expect(aspiration.title).to eq 'This is the new title'
                expect(aspiration.description).to eq 'This is the new description of the updated aspiration.'
            end
        end

        context 'with invalid params' do
            let(:bad_aspiration_params) { {
                title: '',
                description: ''
            } }

            it 'renders edit view' do
                put :update, params: { id: aspiration.id, aspiration: bad_aspiration_params }
                expect(response).to render_template('aspirations/edit')
            end

            it 'sets error message' do
                put :update, params: { id: aspiration.id, aspiration: bad_aspiration_params }
                expect(flash.now[:error]).to eq 'The aspiration was not saved'
            end
        end
    end

    context '#destroy' do
        let(:aspiration) { FactoryBot.create(:aspiration) }

        it 'does a redirect with message' do
            delete :destroy, params: { id: aspiration.id }
            expect(response).to redirect_to(aspirations_path)
            expect(flash[:info]).to eq 'Aspiration has been deleted'
        end

        it 'destroys record' do
            aspiration # create before expect block

            expect do
                delete :destroy, params: { id: aspiration.id }
            end.to change(Aspiration, :count).by(-1)
        end
    end
end