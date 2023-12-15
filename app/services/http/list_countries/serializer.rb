# frozen_string_literal: true

class Http::ListCountries::Serializer < ActiveModel::Serializer
  attributes :id, :name, :code, :demographic_density
end
