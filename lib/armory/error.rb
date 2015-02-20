module Armory
  # Custom error class for rescuing from all Armory errors
  class Error < StandardError
    # @return [Integer]
    attr_reader :code

    class << self
      # Create a new error from an HTTP response
      #
      # @param response [Faraday::Response]
      # @return [Armory::Error]
      def from_response(response)
        message, code = parse_error(response.body)
        new(message, code) # investigate adding response.response_headers here to handle errors
      end

      # @return [Hash]
      def errors
        # Also look at X-Mashery-Error-Code
        @errors ||= {
          # 400 => Armory::Error::BadRequest,
          # 401 => Armory::Error::Unauthorized,
           403 => Armory::Error::Forbidden,
           404 => Armory::Error::NotFound,
          # 406 => Armory::Error::NotAcceptable,
           408 => Armory::Error::RequestTimeout,
          # 420 => Armory::Error::EnhanceYourCalm,
          # 422 => Armory::Error::UnprocessableEntity,
          # 429 => Armory::Error::TooManyRequests,
           500 => Armory::Error::InternalServerError,
           502 => Armory::Error::BadGateway,
           503 => Armory::Error::RateLimited,
           504 => Armory::Error::GatewayTimeout,
        }
      end

      def forbidden_messages
        @forbidden_messages ||= {
          'maintenance' => Armory::Error::Maintenance,
          'Account Inactive' => Armory::Error::IncorrectAPIKey,
        }
      end

    private

      def parse_error(body)
        if body.nil?
          ['', nil]
        elsif body.is_a?(Hash) && body[:detail]
          [body[:detail], nil]
        end
      end

    end

    # Initializes a new Error object
    #
    # @param message [Exception, String]
    # @param rate_limit [Hash]
    # @param code [Integer]
    # @return [Armory::Error]
    def initialize(message = '', code = nil)
      super(message)
      @code = code
    end

    ConfigurationError = Class.new(::ArgumentError)
    IncorrectLastUpdate = Class.new(::ArgumentError)


    # Raised when Armory returns a 4xx HTTP status code
    ClientError = Class.new(self)

    # Raised when Armory::Base does not receive a region
    RegionMissing = Class.new(ClientError)
    InvalidRealm = Class.new(ClientError)

    # Raised when Armory returns the HTTP status code 403
    Forbidden = Class.new(ClientError)
    IncorrectAPIKey = Class.new(Forbidden)

    # Raised when Armory returns the HTTP status code 404
    NotFound = Class.new(ClientError)

    # Raised when Armory returns the HTTP status code 408
    RequestTimeout = Class.new(ClientError)

    # Raised when Armory returns a 5xx HTTP status code
    ServerError = Class.new(self)

    Maintenance = Class.new(ServerError)
    
    # Raised when Armory returns the HTTP status code 500
    InternalServerError = Class.new(ServerError)

    # Raised when Armory returns the HTTP status code 502
    BadGateway = Class.new(ServerError)

    # Raised when Armory returns the HTTP status code 503
    RateLimited = Class.new(ServerError)

    # Raised when Armory returns the HTTP status code 504
    GatewayTimeout = Class.new(ServerError)

    # Raised when Armory returns invalid JSON
    InvalidJSON = Class.new(ServerError)
  end
end
