# ruby-learning

Ruby特有の構文・オブジェクトモデル・イディオムの習得、およびテキスト処理・CLIツール開発などの実践を行うための学習リポジトリです。

## 環境要件

- Docker / Docker Compose

コンテナ内のベースイメージには公式の `ruby:4.0-slim` を使用し、`rspec` と `rubocop` をあらかじめ組み込んでいます。

## セットアップ

```bash
# Dockerイメージのビルド
docker compose build

# Ruby / Bundler / RSpec / RuboCop のバージョン確認
docker compose run --rm app ruby -v
docker compose run --rm app bundle exec rspec -v
docker compose run --rm app bundle exec rubocop -V
```

## よく使うコマンド

```bash
# コンテナ内の対話シェルを起動
docker compose run --rm app bash

# IRB（対話型Ruby）を起動
docker compose run --rm app irb

# Rubyスクリプトを実行
docker compose run --rm app ruby exercises/phase1/sample.rb

# RuboCop で静的解析を実行
docker compose run --rm app bundle exec rubocop

# RSpec でテストを実行（Phase 4 以降）
docker compose run --rm app bundle exec rspec
```

## ディレクトリ構成

```text
.
├── Dockerfile        # Ruby 4.0-slim ベースの学習用イメージ定義
├── compose.yml       # Docker Compose 設定（作業ディレクトリ: /app）
├── Gemfile           # 利用する Gem の定義（rspec, rubocop）
├── road_map.md       # 学習カリキュラム兼進捗チェックリスト
├── exercises/        # フェーズごとのハンズオン課題コード
└── notes/            # 学習メモ・Rubyイディオムの記録
```

## 学習カリキュラム

詳細な進捗とトピック一覧は [road_map.md](./road_map.md) を参照してください。
