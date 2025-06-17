#!/bin/bash

apt-get update

if dpkg -l | grep docker.io; then
    echo "docker package already installed"
else
    apt-get install \
        -y docker.io \
        --no-install-recommends
fi

if dpkg -l | grep docker-compose; then
    echo "docker-compose package already installed"
else
    apt-get install \
        -y docker-compose \
        --no-install-recommends
fi

if dpkg -l | grep -qw python3 && dpkg -l | grep -qw python3-pip; then
    echo "python3 and python3-pip packages already installed"
else
    apt-get install \
        -y python3 python3-pip \
        --no-install-recommends
fi

if pip3 show django > /dev/null 2>&1; then
    echo "Django package already installed"
else
    pip3 install --break-system-packages django
fi
