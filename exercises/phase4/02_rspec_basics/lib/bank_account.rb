# frozen_string_literal: true

class InsufficientFundsError < StandardError; end

class Notifier
  def notify(message)
    puts "[NOTIFY] #{message}"
  end
end

class BankAccount
  attr_reader :balance

  def initialize(balance = 0, notifier: Notifier.new)
    @balance = balance
    @notifier = notifier
  end

  def deposit(amount)
    raise ArgumentError, '預金額は正の数を指定してください' if amount <= 0

    @balance += amount
  end

  def withdraw(amount)
    raise ArgumentError, '引き出し額は正の数を指定してください' if amount <= 0
    raise InsufficientFundsError, '残高が不足しています' if amount > @balance

    @balance -= amount
    @notifier.notify("Withdrew #{amount}")
    @balance
  end
end
