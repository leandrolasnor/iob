# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe CountriesController do
  path '/v1/countries/list' do
    get('list country') do
      tags 'Countries'
      security [{ ApiKeyAuth: [] }]
      parameter name: :page, in: :query, type: :integer, description: 'pagination'
      parameter name: :per_page, in: :query, type: :integer, description: 'pagination'
      response(200, 'successful') do
        let(:countries) { create_list(:country, 6) }
        let(:page) { 2 }
        let(:per_page) { 3 }

        let(:expected_body) do
          [
            {
              id: be_a(Integer),
              name: countries[2].name
            },
            {
              id: be_a(Integer),
              name: countries[1].name
            },
            {
              id: be_a(Integer),
              name: countries[0].name
            }
          ]
        end

        before do
          countries
        end

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(parsed_body).to match(expected_body)
        end
      end
    end
  end

  path '/v1/countries/{id}' do
    let(:country) { create(:country, name: 'Country name', code: 'code', demographic_density: 999) }
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show country') do
      tags 'Country'
      consumes "application/json"
      security [{ ApiKeyAuth: [] }]
      response(200, 'successful') do
        let(:id) { country.id }

        let(:expected_body) do
          {
            name: 'Country name',
            code: 'code',
            demographic_density: 999
          }
        end

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(parsed_body).to eq(expected_body)
        end
      end
    end
  end
end
