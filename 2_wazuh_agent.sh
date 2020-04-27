#!/bin/sh

curl -so wazuh-agent.deb https://packages.wazuh.com/3.x/apt/pool/main/w/wazuh-agent/wazuh-agent_3.12.2-1_amd64.deb
echo "Set WAZUH_MANAGER as the Hostname for WAZUH Manager. Then run dpkg -i wazuh-agent.deb"
