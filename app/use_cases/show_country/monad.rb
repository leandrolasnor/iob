# frozen_string_literal: true

class ShowCountry::Monad
  include Dry::Monads[:try]
  include Dry.Types()
  extend  Dry::Initializer

  option :model, type: Interface(:find), default: -> { ShowCountry::Models::Country }, reader: :private

  def call(id)
    Try(ActiveRecord::RecordNotFound) { model.find(id) }
  end
end
