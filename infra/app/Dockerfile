# ベースイメージ
FROM ruby:3.1.2

# 環境変数を設定
ARG WORKDIR
ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

# 作業ディレクトリを設定
WORKDIR ${HOME}

# 必要なパッケージをインストール
RUN apt-get update -qq 
RUN apt-get install -y default-mysql-client iputils-ping net-tools libssl-dev

# OpenSSL 1.1をダウンロードしてインストール
RUN wget https://www.openssl.org/source/openssl-1.1.1l.tar.gz \
    && tar -zxvf openssl-1.1.1l.tar.gz \
    && cd openssl-1.1.1l \
    && ./config \
    && make \
    && make install

# 環境変数を設定してOpenSSL 1.1とRubyを再インストール
ENV RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/ssl"
RUN rbenv install 3.1.2
RUN rbenv global 3.1.2

# GemfileとGemfile.lockをコピー
COPY Gemfile* ./
# Bundlerでgemをインストール
RUN bundle install -j4

# アプリケーションのソースコードをコピー
COPY . ./

# Entrypointを設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# 必要なディレクトリを作成
RUN mkdir -p /tmp/pids
RUN mkdir -p /tmp/sockets
