require 'rails_helper'

describe ProgressLogsController, type: :controller do
    context '#index' do
        it 'renders root page' do
            get :index
            expect(response).to be_successful
        end

        it 'sets up progress_logs' do
            get :index
            expect(assigns[:progress_logs]).to be_a(ActiveRecord::Relation)
        end
    end
end
