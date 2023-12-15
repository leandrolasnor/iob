# frozen_string_literal: true

class Http::ShowCountry::Serializer < ActiveModel::Serializer
  attributes :name, :code, :demographic_density
end
