# frozen_string_literal: true

class Sse::Map::Service < Sse::Service
  option :monad, type: Interface(:call), default: -> { Map::Monad.new }, reader: :private

  def call
    monad.subscribe('country.fetched') do |event|
      sse.write({ type: 'COUNTRY_FETCHED', payload: event[:payload]})
    end
    res = monad.()

    Rails.logger.error(res.exception) if res.failure?
  end
end
