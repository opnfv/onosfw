# Copyright (c) 2015 OpenStack Foundation
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

import time

from oslo.config import cfg
import requests

from neutron.common import constants as neu_const
from neutron.common import utils
from neutron.extensions import portbindings
from neutron.openstack.common import excutils
from neutron.openstack.common import jsonutils
from neutron.openstack.common import log
from neutron.plugins.common import constants as plu_const
from neutron.plugins.ml2 import driver_api as api

LOG = log.getLogger(__name__)

ONOS_TYPES = {network : 'networks',
              subnet : 'subnets',
              port : 'ports'}

onos_opts = [
    cfg.StrOpt('url',
               help=_("HTTP URL of ONOS REST interface.")),
    cfg.StrOpt('username',
               help=_("HTTP username for authentication")),
    cfg.StrOpt('password', secret=True,
               help=_("HTTP password for authentication")),
    cfg.IntOpt('timeout', default=10,
               help=_("HTTP timeout in seconds.")),
    cfg.IntOpt('session_timeout', default=30,
               help=_("Tomcat session timeout in minutes.")),
]

cfg.CONF.register_opts(onos_opts, "ml2_onos")

class ONOSMechanismDriver(api.MechanismDriver):
    def initialize(self):
	    self.url = cfg.CONF.ml2_onos.url
        self.timeout = cfg.CONF.ml2_onos.timeout
        self.username = cfg.CONF.ml2_onos.username
        self.password = cfg.CONF.ml2_onos.password
		
        required_opts = ('url', 'username', 'password')
        for opt in required_opts:
            if not getattr(self, opt):
                raise cfg.RequiredOptError(opt, 'ml2_onos')
				
        self.vif_type = portbindings.VIF_TYPE_OVS
        self.vif_details = {portbindings.CAP_PORT_FILTER: True}
        self.onos_driver = ONOSDriver()

    def create_network_postcommit(self, context):
        self.onos_driver.sync_data('create', ONOS_TYPES[network], context)

    def update_network_postcommit(self, context):
        self.onos_driver.sync_data('update', ONOS_TYPES[network], context)

    def delete_network_postcommit(self, context):
        self.onos_driver.sync_data('delete', ONOS_TYPES[network], context)

    def create_subnet_postcommit(self, context):
        self.onos_driver.sync_data('create', ONOS_TYPES[subnet], context)

    def update_subnet_postcommit(self, context):
        self.onos_driver.sync_data('update', ONOS_TYPES[subnet], context)

    def delete_subnet_postcommit(self, context):
        self.onos_driver.sync_data('delete', ONOS_TYPES[subnet], context)

    def create_port_postcommit(self, context):
        self.onos_driver.sync_data('create', ONOS_TYPES[port], context)

    def update_port_postcommit(self, context):
        self.onos_driver.sync_data('update', ONOS_TYPES[port], context)

    def delete_port_postcommit(self, context):
        self.onos_driver.sync_data('delete', ONOS_TYPES[port], context)

    def bind_port(self, context):
	    pass
        		
#TODO:Tuning it for later.								
class ONOSDriver(object):
	sync_status= False
	
    def __init__():
	    self.url = cfg.CONF.ml2_onos.url
        self.timeout = cfg.CONF.ml2_onos.timeout
        self.username = cfg.CONF.ml2_onos.username
        self.password = cfg.CONF.ml2_onos.password
		self.auth = (self.username, self.password)
		
    def sync_data(self, action, data_type, context):
        if self.sync_status:
            self.sync_single(action, data_type, context)
        else:
	        self.sync_all(context)

    def sync_all(self, context):
        pass

    def sync_single(self, action, data_type, context):
        pass
