#!/bin/sh

echo "Install OpenDistro Elasticsearch (Security)?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo bin/elasticsearch-plugin install https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-security/opendistro_security-1.6.0.0.zip; break;;
        No ) break ;;
    esac
done

echo "Install OpenDistro Elasticsearch (Job Scheduler)?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo bin/elasticsearch-plugin install https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-job-scheduler/opendistro-job-scheduler-1.6.0.0.zip; break;;
        No ) break ;;
    esac
done

echo "Install OpenDistro Elasticsearch (SQL)?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo bin/elasticsearch-plugin install https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-alerting/opendistro_alerting-1.6.0.0.zip; break;;
        No ) break ;;
    esac
done

echo "Install OpenDistro Elasticsearch (Index State Management)?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo bin/elasticsearch-plugin install https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-index-management/opendistro_index_management-1.6.0.0.zip; break;;
        No ) break ;;
    esac
done

echo "Install OpenDistro Elasticsearch (Anomaly Detection)?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Havent plugged this one in yet... soon."; break;;
        No ) break ;;
    esac
done
