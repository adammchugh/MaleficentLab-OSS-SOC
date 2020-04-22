#!/bin/bash

echo "This is the master installer for the OS SOCaaS environment\n"
echo "The following hosts will be required prior to continuing:\n"
echo "- Elasticsearch x 3 Hosts (4 vCPU & 4GB RAM min. each) \n"
echo "- Kibana/Wazuh/ElastAlert x 1 Host (4 vCPU & 4GB RAM min. each) \n"
echo "- Logstash x 2 Host (2 vCPU & 4GB RAM min. each) \n"
echo "- LoadBalancer x 1 Host (2 vCPU & 4GB RAM min. each) \n"
echo "- TheHive x1 Host (4 vCPU & 4GB RAM min. each) \n"
echo "- Cortex x1 Host (2 vCPU & 4GB RAM min. each) \n"
echo "- MISP x1 Host (4 vCPU & 4GB RAM min. each) \n"
echo "************************************************************ \n"
echo "Please ensure password-less authentication has been configured \n"
echo "on the target hosts prior to continuing. Refer to build documentation \n"
echo "to understand how to configure this. "

read -p "Press enter to continue"

# 1_deploy_elasticsearch.sh --host 123.123.123.123 --nodes 123.123.123.123,234.234.234.234,345.345.345.345
# 1_deploy_alerting.sh --host 124.124.124.124 --nodes 123.123.123.123,234.234.234.234,345.345.345.345
# 1_deploy_loadbalancer.sh --host 125.125.125.125 --nodes 126.126.126.126,127.127.127.127
# 1_deploy_logstash.sh --host 126.126.126.126
# 1_deploy_thehive.sh --host 128.128.128.128 --esnodes 123.123.123.123,234.234.234.234,345.345.345.345 --cortexnode 129.129.129.129
# 1_deploy_cortex.sh --host 129.129.129.129
# 1_deploy_misp.sh --host 130.130.130.130
