# Phase 4: 実践のためのテスト・品質管理入門 学習メモ

## 4-1. Bundler とプロジェクト構成

### 要点
- **Bundler**: `Gemfile` で Gem を宣言し、`Gemfile.lock` でバージョンを固定する。`bundle exec` を付けることで `Gemfile.lock` に記録された正確な環境でコマンドを実行できる。
- **標準ディレクトリ構成**: `lib/`（本体コード）、`spec/`（RSpec テスト）、`exe/`（シバン `#!/usr/bin/env ruby` と実行権限 `chmod +x` を付けた CLI スクリプト）。
- **`require` vs `require_relative`**:
  - `require 'json'`: `$LOAD_PATH` から標準ライブラリや Gem を読み込む。
  - `require_relative '../lib/app'`: 現在のファイルからの相対パスでプロジェクト内ファイルを読み込む（実行時のカレントディレクトリに依存しない）。

### ハマったポイント・メモ
- シバン付きの実行ファイルには `chmod +x` で実行権限を付けないと RuboCop の `Lint/ScriptPermission` で警告される。

---

## 4-2. RSpec の基礎と実践的な書き方

### 要点
- **基本構造**: `RSpec.describe 対象クラス`（中で `described_class` として参照可能）、`describe '#メソッド名'`、`context '〜の場合'`、`it '〜こと'`。
- **テストデータ**: `let`（遅延評価・初回参照時にキャッシュ）、`let!`（即時評価）、`subject`（テスト対象の主役）。
- **主要マッチャー**: `eq`、`change { ... }.by(...)`、`raise_error(ErrorClass)`（例外と状態変化はブロック `{ ... }` で渡す）。
- **モック・スタブ**: `instance_double(ClassName, method: return_value)` で実在しないメソッド呼び出しを防止し、`have_received(:method).with(...).once` でスパイ検証を行う。
- **RuboCop 連携**: RSpec の `describe` / `context` は長くなりやすいため、`.rubocop.yml` で `Metrics/BlockLength` から `**/*_spec.rb` を除外するのが定番。
