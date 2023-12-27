# frozen_string_literal: true

class Map::Monad
  include Dry::Events::Publisher[:country_fetched]
  include Dry::Monads[:try]
  include Dry.Types()
  extend  Dry::Initializer

  register_event('country.fetched')

  option :model, type: Interface(:find_in_batches), default: -> { Map::Models::Country }, reader: :private

  def call
    Try do
      records = []
      model.find_in_batches(batch_size: 10) do |batch|
        publish('country.fetched', payload: batch)
        records += batch
      end
      records
    end
  end
end
