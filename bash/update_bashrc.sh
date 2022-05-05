#!/bin/bash

bashrc_url=x

[ -f /etc/bash.bashrc ] \
    && curl -sSL ${bashrc_url} >> /etc/bash.bashrc \
    || echo "/etc/bash.bashrc文件不存在";exit 1