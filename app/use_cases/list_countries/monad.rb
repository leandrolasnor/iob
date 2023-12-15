# frozen_string_literal: true

class ListCountries::Monad
  include Dry::Monads[:try]
  include Dry.Types()
  extend  Dry::Initializer

  option :model, type: Interface(:page), default: -> { ListCountries::Models::Country }, reader: :private

  def call(page: 1, per_page: 25)
    Try { model.page(page).per(per_page).order(id: :desc) }
  end
end
