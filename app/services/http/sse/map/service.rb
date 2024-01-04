# frozen_string_literal: true

class Http::Sse::Map::Service < Http::Sse::Service
  option :monad, type: Interface(:call), default: -> { Map::Monad.new }, reader: :private

  def call
    monad.subscribe('country.fetched') do |event|
      payload = event[:payload].map do
        {
          country: _1.code,
          value: _1.demographic_density
        }
      end
      sse.write({ type: 'COUNTRY_FETCHED', payload: payload })
    end
    res = monad.()

    Rails.logger.error(res.exception) if res.failure?
  end
end
