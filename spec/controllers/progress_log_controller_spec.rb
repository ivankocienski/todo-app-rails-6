require 'rails_helper'

describe ProgressLogsController, type: :controller do
    let(:progress_log) { FactoryBot.create(:progress_log) }

    context 'navigation' do
        controller do
            def peek_navigation
                render plain: ''
            end
        end

        before :each do
            routes.draw { get 'peek_navigation' => 'progress_logs#peek_navigation' }
        end

        it 'is set up correctly' do
            get :peek_navigation
            expect(assigns[:navigation]).to eq :progress_logs
        end
    end

    context '#find_progress_log_from_param_id' do
        controller do
            before_action :find_progress_log_from_param_id, only: %i[edit]

            def edit
                render plain: ''
            end
        end

        context 'with valid progress log ID' do
            it 'sets up @progress_log object' do
                get :edit, params: { id: progress_log.id }
                expect(assigns[:progress_log]).to be_a(ProgressLog)
            end
        end

        context 'with invalid progress log ID' do
            it 'responds with correct status' do
                get :edit, params: { id: 123 }
                expect(response.status).to eq 404
            end
        end
    end

    context '#index' do
        before :each do
            get :index
        end

        it 'renders page' do
            expect(response).to be_successful
        end

        it 'sets up progress_logs' do
            expect(assigns[:progress_logs]).to be_a(ActiveRecord::Relation)
        end
    end

    context '#show' do
        it 'renders correct view' do
            get :show, params: { id: progress_log.id }
            expect(response).to render_template('show')
        end
    end

    context '#new' do
        before :each do
            get :new
        end

        it 'renders page' do
            expect(response).to render_template('new')
        end

        it 'sets up progress_log object' do
            expect(assigns[:progress_log]).to be_a(ProgressLog)
        end

        it 'has open_todo_items' do
            expect(assigns[:open_todo_items]).to be_a(ActiveRecord::Relation)
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

            it 'associates with todo_item when present' do
                todo_item = FactoryBot.create(:todo_item)
                params = progress_log_params
                params[:todo_item_id] = todo_item.id
                post :create, params: { progress_log: params }

                progress_log = assigns[:progress_log]
                expect(progress_log.todo_item).to be_a(TodoItem)
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
                expect(assigns[:progress_log]).not_to be_valid
            end

            it 'does not save with invalid todo_item_id' do
                bad_params = {
                    on_day: DateTime.new,
                    description: 'This is a long description of the pogress I have made today',
                    todo_item_id: 1234
                }

                post :create, params: { progress_log: bad_params }
                expect(assigns[:progress_log]).not_to be_valid
            end
        end
    end
end
