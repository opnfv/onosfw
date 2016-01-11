# Copyright (c) 2013 Hewlett-Packard Development Company, L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.


"""
Description:
    This file is used to run testcase
    lanqinglong@huawei.com
"""
from environment import environment
import os
import time
import pexpect
import re

class client( environment ):

    def __init__( self ):
        environment.__init__( self )
        self.loginfo = environment()
        self.testcase = ''

    def RunScript( self, handle, testname, timeout=300 ):
        """
        Run ONOS Test Script
        Parameters:
        testname: ONOS Testcase Name
        masterusername: The server username of running ONOS
        masterpassword: The server password of running ONOS
        """
        self.testcase = testname
        self.ChangeTestCasePara( testname, self.masterusername, self.masterpassword )
        runhandle = handle
        runtest = self.home + "/OnosSystemTest/TestON/bin/cli.py run " + testname
        runhandle.sendline(runtest)
        circletime = 0
        lastshowscreeninfo = ''
        while True:
            Result = runhandle.expect(["PEXPECT]#", pexpect.EOF, pexpect.TIMEOUT])
            curshowscreeninfo = runhandle.before
            if (len(lastshowscreeninfo) != len(curshowscreeninfo)):
                print str(curshowscreeninfo)[len(lastshowscreeninfo)::]
                lastshowscreeninfo = curshowscreeninfo
            if Result == 0:
                print "Done!"
                return
            time.sleep(1)
            circletime += 1
            if circletime > timeout:
                break
        self.loginfo.log( "Timeout when running the test, please check!" )

    def onosstart( self ):
        #This is the compass run machine user&pass,you need to modify

        print "Test Begin....."
        self.OnosConnectionSet()
        masterhandle = self.SSHlogin(self.localhost, self.masterusername,
                                    self.masterpassword)
        self.OnosEnvSetup( masterhandle )
        return masterhandle

    def onosclean( self, handle ):
        self.SSHRelease( handle )
        self.loginfo.log('Release onos handle Successful')

    def push_results_to_db( self, payload, pushornot = 1):
        url = self.Result_DB + "/results"
        params = {"project_name": "functest", "case_name": "ONOS-" + self.testcase,
                  "pod_name": 'huawei-build-2', "details": payload}
        headers = {'Content-Type': 'application/json'}
        r = requests.post(url, data=json.dumps(params), headers=headers)
        self.loginfo.log('Pushing result via Northbound, info:' + r )
