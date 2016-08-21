FROM centos:6

ENV APP_ROOT=/usr/local/hiyaoroshigo

WORKDIR $APP_ROOT

RUN yum install -y gcc openssl-devel readline-devel zlib-devel sqlite-devel
RUN yum install -y git

RUN curl -sL https://rpm.nodesource.com/setup_4.x | bash -
RUN yum install -y nodejs

RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
ENV PATH="/root/.rbenv/bin:/root/.rbenv/shims:$PATH"

RUN echo 'eval "$(rbenv init -)"' > /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /root/.bashrc
RUN source /etc/profile.d/rbenv.sh
RUN rbenv install 2.3.1
RUN rbenv global 2.3.1

RUN echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc
RUN gem update --system
RUN gem install rails --no-rdoc --no-ri

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN bundle config --global build.nokogiri --use-system-libraries && \
  bundle install

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
