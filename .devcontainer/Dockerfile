ARG RUBY_VERSION=3.2
ARG REDMINE_VERSION=master
FROM haru/redmine_devcontainer:${REDMINE_VERSION}-ruby${RUBY_VERSION}
COPY .devcontainer/post-create.sh /post-create.sh

RUN apt-get update && apt-get install -y default-mysql-client && rm -rf /var/lib/apt/lists/*

USER vscode
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
