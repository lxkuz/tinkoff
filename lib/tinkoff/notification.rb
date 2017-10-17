module Tinkoff
  class Notification
    attr_reader :terminal_key, :order_id, :success, :status, :payment_id,
                :error_code, :amount, :rebill_id, :card_id, :pan, :token,
                :customer_key

    def initialize(params)
      @terminal_key = params['TerminalKey']
      @order_id = params['OrderId']
      @success = params['Success'] == 'true'
      @status = params['Status']
      @payment_id = params['PaymentId'].to_i
      @error_code = params['ErrorCode']
      @error_message = params['ErrorMessage']
      @amount = params['Amount'].to_i
      @rebill_id = params['RebillId'].to_i
      @card_id = params['CardId'].to_i
      @pan = params['Pan']
      @token = params['Token']
      @customer_key = params['CustomerKey'].to_s
      @fiscal_number = params['FiscalNumber']
      @shift_number = params['ShiftNumber']
      @receipt_date_time = params['ReceiptDatetime']
      @fn_number = params['FnNumber']
      @erc_reg_number = params['EcrRegNumber']
      @fiscal_document_number = params['FiscalDocumentNumber']
      @fiscal_document_attributes = params['FiscalDocumentAttribute']
    end

    def success?
      @success
    end

    def failure?
      !@success
    end
  end
end
