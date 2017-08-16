module Tinkoff
  class Client
    # Инициирует платежную сессию и регистрирует заказ в системе Банка
    def self.init(amount, order_id, data, params = {})
      params = params.merge(Amount: amount, OrderId: order_id, DATA: data)
      Tinkoff::Request.new('Init', params).perform
    end

    # Данный метод используется, если продавец обладает сертификацией PCI DSS
    # и использует свою собственную платежную форму вместо формы банка.
    # TODO: Implement
    def self.finish_authorize(params = {})
      Tinkoff::Request.new('FinishAuthorize', params).perform
    end

    # Подтверждает платеж и осуществляет списание заблокированных ранее денежных средств
    def self.confirm(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      Tinkoff::Request.new('Confirm', params).perform
    end

    # Привязка покупателя
    def self.add_customer(customer_key, params = {})
      params = params.merge(CustomerKey: customer_key)
      Tinkoff::Request.new('AddCustomer', params).perform
    end

    #Получает данные покупателя
    def self.get_customer(customer_key, params = {})
      params = params.merge(CustomerKey: customer_key)
      Tinkoff::Request.new('GetCustomer', params).perform
    end

    #Удаляет привязанного покупателя
    def self.remove_customer(customer_key, params = {})
      params = params.merge(CustomerKey: customer_key)
      Tinkoff::Request.new('RemoveCustomer', params).perform
    end

    #Список карт покупателя
    def self.get_card_list(customer_key, params = {})
      puts '2'
      params = params.merge(CustomerKey: customer_key)
      Tinkoff::Request.new('GetCardList', params).apply
    end

    # Осуществляет рекуррентный (повторный) платеж — безакцептное списание денежных средств
    # со счета банковской карты Покупателя
    def self.charge(payment_id, rebill_id, params = {})
      params = params.merge(PaymentId: payment_id, RebillId: rebill_id)
      Tinkoff::Request.new('Charge', params).perform
    end

    # Отменяет платежную сессию
    def self.cancel(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      Tinkoff::Request.new('Cancel', params).perform
    end

    # Возвращает текуший статус платежа
    def self.state(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      Tinkoff::Request.new('GetState', params).perform
    end
  end
end
