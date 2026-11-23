FROM ruby:4.0-slim

# ネイティブ拡張を含む Gem のビルドや開発に必要な最小限のパッケージを導入
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
       build-essential \
       libyaml-dev \
       git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV BUNDLE_PATH=/usr/local/bundle

COPY Gemfile* ./
RUN bundle install

CMD ["bash"]
