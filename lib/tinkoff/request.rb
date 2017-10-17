module Tinkoff
  class Request
    BASE_URL = 'https://securepay.tinkoff.ru/rest/'

    def initialize(path, params = {})
      @url = BASE_URL + path
      @params = params
    end

    def perform
      prepare_params
      http_params = {body: @params, format: :json}
      http_params[:debug_output] = $stdout if Tinkoff.config.debug
      response = HTTParty.post(@url, http_params).parsed_response
      Tinkoff::Payment.new(response)
    end
    
    def apply
      prepare_params
      http_params = {body: @params, format: :json}
      http_params[:debug_output] = $stdout if Tinkoff.config.debug
      response = HTTParty.post(@url, http_params).parsed_response
      return response
    end

    private

    def prepare_params
      # Encode and join DATA hash
      prepare_data
      # Add terminal key and password
      @params.merge!(default_params)
      # Sort params by key
      @params = @params.sort.to_h
      # Add token (signature)
      @params[:Token] = token
      # Delete SecretKey
      @params.delete(:Password)
    end

    # Params signature
    def token
      values = @params.values.join
      Digest::SHA256.hexdigest(values)
    end

    def default_params
      {
        TerminalKey: Tinkoff.config.terminal_key,
        Password: Tinkoff.config.password
      }
    end

    # Ключ=значение дополнительных параметров через “|”, например Email=a@test.ru|Phone=+71234567890
    def prepare_data
      return unless @params[:DATA].present?
      @params[:DATA] = @params[:DATA].to_query.tr('&', '|')
    end
  end
end
