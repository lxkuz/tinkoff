module Tinkoff
  class Payment
    attr_reader :terminal_key, :amount, :order_id, :success, :status,
                :payment_id, :error_code, :payment_url, :message, :details,
                :rebill_id, :card_id, :pan, :card_type

    # Attributes for Cancel method
    attr_reader :original_amount, :new_amount

    def initialize(response)
      @terminal_key = response['TerminalKey']
      @amount = response['Amount']
      @order_id = response['OrderId']
      @success = response['Success']
      @status = response['Status']
      @payment_id = response['PaymentId']
      @error_code = response['ErrorCode']
      @payment_url = response['PaymentURL']
      @message = response['Message']
      @details = response['Details']
      @rebill_id = response['RebillId']
      @card_id = response['CardId']
      @pan = response['Pan']
      @card_type = response['CardType'].to_s

      # Attributes for Cancel method
      @original_amount = response['OriginalAmount']
      @new_amount = response['NewAmount']
    end

    def failure?
      !@success
    end

    def success?
      !failure?
    end
  end
end
