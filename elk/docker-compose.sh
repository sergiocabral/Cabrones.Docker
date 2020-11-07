#!/bin/bash

read_variable () {
    NAME="$1";
    VALUE=$(
        cat .env | \
        grep $NAME | \
        grep -Eo '=.+$'
    );
    VALUE=${VALUE:1};
    RETURNED=$VALUE;
}

read_variable "HostDirectoryData";
HostDirectoryData=$RETURNED;

read_variable "HostDirectoryTemporary";
HostDirectoryTemporary=$RETURNED;

read_variable "ElasticsearchName";
ElasticsearchName=$RETURNED;

read_variable "LogstashName";
LogstashName=$RETURNED;

read_variable "KibanaName";
KibanaName=$RETURNED;

HostDirectoryDataElasticsearch=$(realpath "$HostDirectoryData/$ElasticsearchName");
HostDirectoryTemporaryElasticsearch=$(realpath "$HostDirectoryTemporary/$ElasticsearchName");
HostDirectoryDataLogstash=$(realpath "$HostDirectoryData/$LogstashName");
HostDirectoryTemporaryLogstash=$(realpath "$HostDirectoryTemporary/$LogstashName");
HostDirectoryDataKibana=$(realpath "$HostDirectoryData/$KibanaName");
HostDirectoryTemporaryKibana=$(realpath "$HostDirectoryTemporary/$KibanaName");

echo "Creating directories and/or fixing permissions:";

mkdir -p $HostDirectoryDataElasticsearch/data;
mkdir -p $HostDirectoryTemporaryElasticsearch/log;
mkdir -p $HostDirectoryDataLogstash/data;
mkdir -p $HostDirectoryTemporaryLogstash/log;
mkdir -p $HostDirectoryDataKibana/data;
mkdir -p $HostDirectoryTemporaryKibana/log;

chown -R 1000:1000 $HostDirectoryDataElasticsearch;
chown -R 1000:1000 $HostDirectoryTemporaryElasticsearch;
chown -R 1000:1000 $HostDirectoryDataLogstash;
chown -R 1000:1000 $HostDirectoryTemporaryLogstash;
chown -R 1000:1000 $HostDirectoryDataKibana;
chown -R 1000:1000 $HostDirectoryTemporaryKibana;

ls -Flad $HostDirectoryDataElasticsearch;
ls -Flad $HostDirectoryTemporaryElasticsearch;
ls -Flad $HostDirectoryDataLogstash;
ls -Flad $HostDirectoryTemporaryLogstash;
ls -Flad $HostDirectoryDataKibana;
ls -Flad $HostDirectoryTemporaryKibana;

docker-compose $*
