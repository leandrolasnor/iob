# frozen_string_literal: true

class Http::ListCountries::Service < Http::Service
  option :serializer, type: Interface(:serializer_for), default: -> { Http::ListCountries::Serializer }, reader: :private
  option :monad, type: Interface(:call), default: -> { ListCountries::Monad.new }, reader: :private

  Contract = Http::ListCountries::Contract.new

  def call
    res = monad.call(**params.symbolize_keys)

    return [:ok, res.value!, serializer] if res.success?

    Rails.logger.error(res.exception)
    [:internal_server_error, res.exception.message]
  end
end
