# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe CountriesController do
  path '/v1/countries/map' do
    get('list country') do
      tags 'Countries'
      security [{ ApiKeyAuth: [] }]
      response(200, 'successful') do
        let(:countries) { create_list(:country, 6) }
        let(:parsed_body) { eval("{ #{response.body} }") }

        let(:expected_body) do
          {
            data: {
              type: 'COUNTRY_FETCHED',
              payload: [
                { country: countries.first.code, value: countries.first.demographic_density },
                { country: countries.second.code, value: countries.second.demographic_density },
                { country: countries.third.code, value: countries.third.demographic_density },
                { country: countries.fourth.code, value: countries.fourth.demographic_density },
                { country: countries.fifth.code, value: countries.fifth.demographic_density },
                { country: countries.last.code, value: countries.last.demographic_density }
              ]
            }
          }
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
end
