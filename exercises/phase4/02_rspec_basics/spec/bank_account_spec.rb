# frozen_string_literal: true

require_relative '../lib/bank_account'

RSpec.describe BankAccount do
  # TODO: let(:notifier) を使って Notifier の instance_double を定義してください
  #       （notify メソッドが呼ばれたら true を返すようにスタブ化）
  let(:notifier) { instance_double(Notifier, notify: true) }

  # TODO: let(:account) を使って described_class.new(1000, notifier:) を定義してください
  let(:account) { BankAccount.new(1000, notifier:) }

  describe '#deposit' do
    context '正の金額を指定した場合' do
      it '残高がその金額だけ増えること' do
        # TODO: expect { ... }.to change { account.balance }.by(500) を使って検証してください
        expect { account.deposit(500) }.to change { account.balance }.by(500)
      end
    end

    context '0以下の金額を指定した場合' do
      it 'ArgumentError が発生すること' do
        # TODO: expect { ... }.to raise_error(ArgumentError) を使って検証してください
        expect { account.deposit(0) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#withdraw' do
    context '残高が十分な場合' do
      it '残高が減り、新しい残高が返ること' do
        # TODO: account.withdraw(400) の戻り値(600)と account.balance(600) を eq で検証してください
        expect(account.withdraw(400)).to eq(600)
        expect(account.balance).to eq(600)
      end

      it 'Notifier#notify が正しいメッセージで1回呼ばれること' do
        # TODO: account.withdraw(400) を実行したあと、
        #       expect(notifier).to have_received(:notify).with('Withdrew 400').once で検証してください
        account.withdraw(400)
        expect(notifier).to have_received(:notify).with('Withdrew 400').once
      end
    end

    context '残高が不足している場合' do
      it 'InsufficientFundsError が発生し、通知が送られないこと' do
        # TODO: InsufficientFundsError が発生することを検証し、
        #       expect(notifier).not_to have_received(:notify) も確認してください
        expect { account.withdraw(1001) }.to raise_error(InsufficientFundsError)
        expect(notifier).not_to have_received(:notify)
      end
    end
  end
end
