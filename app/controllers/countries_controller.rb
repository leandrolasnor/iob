# frozen_string_literal: true

class CountriesController < BaseController
  include ActionController::Live
  skip_before_action :authenticate_user!, :only => [:map]

  def show
    status, content, serializer = Http::ShowCountry::Service.(show_params)
    render json: content, status: status, serializer: serializer
  end

  def list
    status, content, serializer = Http::ListCountries::Service.(list_params)
    render json: content, status: status, each_serializer: serializer
  end

  def map
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream, event: "COUNTRY_FETCHED")
    ShowCountry::Models::Country.find_in_batches(batch_size: 100) do |countries|
      countries.map do |country|
        sse.write({ country: country.code, value: country.demographic_density })
      end
    end
  ensure
    sse.close
  end

  private

  def show_params
    params.permit(:id)
  end

  def list_params
    params.permit(:page, :per_page)
  end
end
