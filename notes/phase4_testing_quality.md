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
