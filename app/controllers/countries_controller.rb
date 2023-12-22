# frozen_string_literal: true

class CountriesController < BaseController
  skip_after_action :update_auth_header, only: %i[map]

  def map
    Sse::Map::Service.(response: response)
  end
end
