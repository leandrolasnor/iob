# frozen_string_literal: true

class Http::ShowCountry::Service < Http::Service
  option :serializer, type: Interface(:serializer_for), default: -> { Http::ShowCountry::Serializer }, reader: :private
  option :monad, type: Interface(:call), default: -> { ShowCountry::Monad.new }, reader: :private

  def call
    res = monad.call(params[:id])

    return [:ok, res.value!, serializer] if res.success?

    [:unprocessable_entity, res.exception.message]
  end
end
