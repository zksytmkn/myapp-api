FROM ruby:3.1.2

ARG WORKDIR

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

WORKDIR ${HOME}

COPY Gemfile* ./

RUN apt-get update -qq 
RUN apt-get install -y default-mysql-client
RUN bundle install -j4

COPY . ./

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]