# frozen_string_literal: true

class Http::ListCountries::Serializer < ActiveModel::Serializer
  attributes :id, :name
end
