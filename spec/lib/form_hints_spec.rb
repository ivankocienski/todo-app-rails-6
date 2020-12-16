require 'rails_helper'

describe FormHints do
    before :each do
        FormHints.reset
    end

    context '#lookup' do
        context 'with no data' do
            it 'returns empty array by default' do
                hints = FormHints.lookup(:model, :field)
                expect(hints).to eq []
            end
        end

        context 'with data' do
            let(:form_hint_db_path) do
                File.join(Rails.root, '/spec/fixtures/form_hints/some_hints_db.yml')
            end

            before :each do
                FormHints.load_from form_hint_db_path
            end

            it 'returns array of hints for field' do
                hints = FormHints.lookup(:sample_model, :sample_field)
                expect(hints).to be_a(Array)
                expect(hints.length).to eq 3
            end

            it 'handles missing model' do
                hints = FormHints.lookup(:not_model, :sample_field)
                expect(hints).to eq []
            end

            it 'handles missing field' do
                hints = FormHints.lookup(:empty_model, :not_field)
                expect(hints).to eq []
            end

            it 'handles empty field' do
                hints = FormHints.lookup(:sample_model, :empty_field)
                expect(hints).to eq []
            end
        end
    end
end