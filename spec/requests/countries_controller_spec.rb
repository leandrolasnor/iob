# frozen_string_literal: true

require 'swagger_helper'
require 'webmock/rspec'

RSpec.describe CountriesController do
  path '/v1/countries/map' do
    get('list country') do
      tags 'Countries'
      security [{ ApiKeyAuth: [] }]
      response(200, 'successful') do
        let(:countries) { create_list(:country, 11) }
        let(:url) { 'fake.com/stream' }
        let(:client) { SSE::EventSource.new(url) }
        let(:expected_second_event) do
          [
            {
              'country' => countries.last.code,
              'value' => countries.last.demographic_density
            }
          ]
        end
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
          WebMock.stub_request(:get, url).to_return(
            body: response.body,
            headers: response.headers
          )
          events = []
          es = SSE::EventSource.new(url)
          es.message do |event|
            events << JSON.parse(event)
          end
          es.start

          expect(response).to have_http_status(:ok)
          expect(response.headers['Content-Type']).to eq('text/event-stream')
          expect(events.count).to eq(2)
          expect(events.first['payload'].count).to eq(10)
          expect(events.second['payload'].count).to eq(1)
          expect(events.second['payload']).to eq(expected_second_event)
        end
      end
    end
  end
end
