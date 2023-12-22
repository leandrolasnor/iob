# frozen_string_literal: true

class CountriesController < BaseController
  include ActionController::Live

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
    response.headers['Last-Modified'] = Time.now.httpdate
    sse = SSE.new(response.stream, event: 'message')
    ShowCountry::Models::Country.find_in_batches(batch_size: 10) do |group|
      sse.write({ type: 'COUNTRY_FETCHED', payload: group.map { { country: _1.code, value: _1.demographic_density } } })
    end
  rescue ActionController::Live::ClientDisconnected
    sse.close
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
