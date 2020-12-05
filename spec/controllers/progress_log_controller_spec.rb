require 'rails_helper'

describe ProgressLogsController, type: :controller do
    context '#index' do
        it 'renders page' do
            get :index
            expect(response).to be_successful
        end

        it 'sets up progress_logs' do
            get :index
            expect(assigns[:progress_logs]).to be_a(ActiveRecord::Relation)
        end
    end

    context '#new' do
        it 'renders page' do
            get :new
            expect(response).to render_template('new')
        end

        it 'sets up progress_log object' do
            get :new
            expect(assigns[:progress_log]).to be_a(ProgressLog)
        end
    end

    context '#create' do
        context 'with valid params' do
            let(:progress_log_params) do
                {
                    on_day: DateTime.new,
                    description: 'This is a long description of the pogress I have made today'
                }
            end

            it 'does a redirect with message' do
                post :create, params: { progress_log: progress_log_params }

                expect(response).to redirect_to(progress_logs_path)
                expect(flash[:info]).to eq 'Progress has been logged!'
            end

            it 'saves info' do
                post :create, params: { progress_log: progress_log_params }

                progress_log = assigns[:progress_log]
                expect(progress_log).to be_a(ProgressLog)
                expect(progress_log).to be_persisted
            end
        end

        context 'with invalid params' do
            let(:bad_progress_log_params) do
                {
                    on_day: DateTime.new,
                    description: ''
                }
            end

            it 'takes user back to "new" with message' do
                post :create, params: { progress_log: bad_progress_log_params }
                expect(flash.now[:error]).to eq 'Did not save progress log'
                expect(response).to render_template('new')
            end

            it 'does not save' do
                post :create, params: { progress_log: bad_progress_log_params }
                expect(assigns[:progress_log]).not_to be_persisted
            end
        end
    end
end
