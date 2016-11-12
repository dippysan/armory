require 'faraday'
require 'armory/error'

module Armory
  module REST
    module Response
      class RaiseError < Faraday::Response::Middleware
        def on_complete(response)
          status_code = response.status.to_i
          klass = Armory::Error.errors[status_code]
          return unless klass
          if klass == Armory::Error::Forbidden
            fail(handle_forbidden_errors(response))
          else
            fail(klass.from_response(response))
          end
        end

      private

        def handle_forbidden_errors(response)
          error = Armory::Error::Forbidden.from_response(response)
          klass = Armory::Error.forbidden_messages[error.message]
          if klass
            klass.from_response(response)
          else
            error
          end
        end
      end
    end
  end
end

Faraday::Response.register_middleware :armory_raise_error => Armory::REST::Response::RaiseError
