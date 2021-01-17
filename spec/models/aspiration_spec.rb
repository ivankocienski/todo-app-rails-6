require 'rails_helper'

RSpec.describe Aspiration, type: :model do
    describe 'validates' do
        context 'title' do
            it do
                should validate_length_of(:title)
                    .is_at_least(5)
                    .is_at_most(200)
            end
        end

        it { is_expected.to have_many(:todo_lists) }
    end
end
