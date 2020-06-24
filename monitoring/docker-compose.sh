#!/bin/bash

VIRTUALIZATION=$(systemd-detect-virt -v) docker-compose $*
