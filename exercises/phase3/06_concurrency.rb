# frozen_string_literal: true

# Phase 3-6: 並行・並列処理の基礎知識 ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase3/06_concurrency.rb
#   docker compose exec app bundle exec rubocop exercises/phase3/06_concurrency.rb

# 1. Thread を使った I/O 並列実行
# - items の各要素ごとに Thread.new(item) { |target| ... } を起動する
# - スレッド内で sleep 0.2 を実行し、"done:#{target}" を返す
# - 最後に threads.map(&:value) で全スレッドの結果を回収して返す
def fetch_all_parallel(items)
  # TODO: 実装してください
  threads = items.map do |item|
    Thread.new(item) do |target|
      sleep 0.2
      "done:#{target}"
    end
  end

  threads.map(&:value)
end

# 2. Mutex による排他制御
# - counter = 0 と mutex = Mutex.new を用意する
# - 5 本のスレッドを作成し、各スレッド内で times_per_thread 回ループして
#   mutex.synchronize { counter += 1 } を実行する
# - 全スレッドを join したあと counter を返す
def safe_increment(times_per_thread)
  # TODO: 実装してください
  counter = 0
  mutex = Mutex.new

  threads = 5.times.map do
    Thread.new do
      times_per_thread.times { mutex.synchronize { counter += 1 } }
    end
  end
  threads.each(&:join)
  counter
end

# 3. Fiber による協調的コルーチン
# - Fiber.new do ... end を作成して返す
# - 1回目の resume で 'step 1' (Fiber.yield('step 1'))
# - 2回目の resume で 'step 2' (Fiber.yield('step 2'))
# - 3回目の resume で 'done' を返す
def create_step_fiber
  # TODO: 実装してください
  Fiber.new do
    Fiber.yield('step1')
    Fiber.yield('step2')
    'done'
  end
end

# --- 動作確認用コード ---
puts '=== 1. Thread による I/O 並列実行 (0.2秒 × 5件) ==='
start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
results = fetch_all_parallel(%w[A B C D E])
elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time

p results # => ["done:A", "done:B", "done:C", "done:D", "done:E"]
puts format('経過時間: %.2f秒 (直列なら 1.00秒 かかります)', elapsed)

puts "\n=== 2. Mutex によるスレッドセーフな加算 ==="
p safe_increment(1000) # => 5000

puts "\n=== 3. Fiber の一時停止と再開 ==="
fiber = create_step_fiber
p fiber.resume # => "step 1"
p fiber.resume # => "step 2"
p fiber.resume # => "done"
