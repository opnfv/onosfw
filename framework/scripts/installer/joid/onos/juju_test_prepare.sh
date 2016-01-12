#!/bin/bash

# launch eht1 on computer nodes and remove default gw route
# Update gateway mac to onos for l3 function

# author: York(Yuanyou)

GW_IP=$(maas maas networks read | grep default_gateway | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')

CIDR=$(maas maas networks read | grep description | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}/24')

# launch eht1 on computer nodes and remove default gw route
launch_eth1() {
  computer_list=$(juju status --format short | grep -Eo 'nova-compute/[0-9]')
  for node in $computer_list; do
    echo "node name is ${node}"
    juju ssh $node "sudo ifconfig eth1 up"
    juju ssh $node "sudo route del default gw $GW_IP"
  done
}

# create external network and subnet in openstack
create_ext_network() {
  keystoneIp=$(juju status --format short | grep keystone/0 | grep -v ha | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')
  configOpenrc admin openstack admin http://$keystoneIp:5000/v2.0 Canonical
  juju scp ./admin-openrc nova-cloud-controller/0:
  juju ssh nova-cloud-controller/0 "source admin-openrc;neutron net-create ext-net --shared --router:external=True;neutron subnet-create ext-net --name ext-subnet $CIDR"
}

configOpenrc()
{
    echo  "  " > ./admin-openrc
    echo  "export OS_USERNAME=$1" >> ./admin-openrc
    echo  "export OS_PASSWORD=$2" >> ./admin-openrc
    echo  "export OS_TENANT_NAME=$3" >> ./admin-openrc
    echo  "export OS_AUTH_URL=$4" >> ./admin-openrc
    echo  "export OS_REGION_NAME=$5" >> ./admin-openrc
 }

# Update gateway mac to onos for l3 function
update_gw_mac() {
  ## get gateway mac
  GW_MAC=$(juju ssh nova-compute/0 "arp -a ${GW_IP} | grep -Eo '([0-9a-fA-F]{2})(([/\s:-][0-9a-fA-F]{2}){5})'")
  ## set external gateway mac in onos
  cmd="/opt/onos/bin/onos \'externalgateway-update -m $GW_MAC\'"
  juju ssh onos-controller/0 "echo $cmd  > update_mac.sh"
  ## delete the ^M
  juju ssh onos-controller/0 "cat -v update_mac.sh |tr -d "^M" > update_mac1.sh"
  juju ssh onos-controller/0 "sh update_mac1.sh"

}

main() {
  launch_eth1
  create_ext_network
  update_gw_mac
}

main "$@"
