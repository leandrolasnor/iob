# frozen_string_literal: true

class CountriesController < BaseController
  def show
    status, content, serializer = Http::ShowCountry::Service.(show_params)
    render json: content, status: status, serializer: serializer
  end

  def list
    status, content, serializer = Http::ListCountries::Service.(list_params)
    render json: content, status: status, each_serializer: serializer
  end

  private

  def show_params
    params.permit(:id)
  end

  def list_params
    params.permit(:page, :per_page)
  end
end
