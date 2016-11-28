# Alpine OS 3.4
# http://dl-cdn.alpinelinux.org/alpine/v3.4/community/x86_64/
FROM alpine:3.4

MAINTAINER Tuan Vo <vohungtuan@gmail.com>

ENV ANSIBLE_VERSION v2.2.1.0-0.1.rc1

RUN set -x \
 && apk add --update bash \
                     curl \
                     openssl \
                     openssh-client \
                     python \
                     py-boto \
                     py-dateutil \
                     py-httplib2 \
                     py-jinja2 \
                     py-paramiko \
                     py-pip \
                     py-setuptools \
                     py-yaml \
                     tar \
                     git \
    && pip install --upgrade pip python-keyczar \
    && rm -rf /var/cache/apk/* \
    && mkdir /etc/ansible/ /ansible \
    && echo "[local]" >> /etc/ansible/hosts \
    && echo "localhost" >> /etc/ansible/hosts \
    && curl -fsSL https://github.com/ansible/ansible/archive/${ANSIBLE_VERSION}.tar.gz -o ansible.tar.gz \
    && tar -xzf ansible.tar.gz -C ansible --strip-components 1 \
    && rm -fr ansible.tar.gz /ansible/docs /ansible/examples /ansible/packaging \
    && mkdir -p /ansible/playbooks

# COPY docker-entrypoint.sh /

# RUN set -x \
 # && chmod +x /docker-entrypoint.sh

WORKDIR /ansible/playbooks 
 
ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib

# ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["ansible-playbook"]