/*
 * Copyright 2015 Open Networking Laboratory
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.onosproject.vtnrsc.sfc;

import org.onlab.packet.IpPrefix;
import org.onosproject.vtnrsc.TenantId;
import org.onosproject.vtnrsc.VirtualPortId;
/**
 * Abstraction of an entity which provides flow classifier for service function chain.
 */
public interface FlowClassifier {

    /**
     * Returns flow classifier ID.
     *
     * @return flow classifier id
     */
    FlowClassifierId flowClassifierId();

    /**
     * Returns Tenant ID.
     *
     * @return tenant Id
     */
    TenantId tenantId();

    /**
     * Returns flow classifier name.
     *
     * @return flow classifier name
     */
    String flowclassifierName();

    /**
     * Returns flow classifier description.
     *
     * @return flow classifier description
     */
    String flowClassifierDescription();

    /**
     * Returns ethernet type.
     *
     * @return ethernet type
     */
    String etherType();

    /**
     * Returns IP Protocol.
     *
     * @return IP protocol
     */
    String ipProtocol();

    /**
     * Returns minimum source port range.
     *
     * @return minimum source port range
     */
    int minSrcPortRange();

    /**
     * Returns maximum source port range.
     *
     * @return maximum source port range
     */
    int maxSrcPortRange();

    /**
     * Returns minimum destination port range.
     *
     * @return minimum destination port range
     */
    int minDstPortRange();

    /**
     * Returns maximum destination port range.
     *
     * @return maximum destination port range.
     */
    int maxDstPortRange();

    /**
     * Returns Source IP prefix.
     *
     * @return Source IP prefix
     */
    IpPrefix srcIpPrefix();

    /**
     * Returns Destination IP prefix.
     *
     * @return Destination IP prefix
     */
    IpPrefix dstIpPrefix();

    /**
     * Returns Source virtual port.
     *
     * @return Source virtual port
     */
    VirtualPortId srcVirtualPort();

    /**
     * Returns Destination virtual port.
     *
     * @return Destination virtual port
     */
    VirtualPortId dstVirtualPort();

    /**
     * Returns whether this Flow classifier is an exact match to the
     * Flow classifier given in the argument.
     *
     * @param flowClassifier other flowClassifier to match against
     * @return true if the flowClassifiers are an exact match, otherwise false
     */
    boolean exactMatch(FlowClassifier flowClassifier);

    /**
     * Builder for flow Classifier.
     */
    interface Builder {

        /**
         * Returns Flow Classifier.
         *
         * @return flow classifier.
         */
        FlowClassifier build();

        /**
         * Sets Flow Classifier ID.
         *
         * @param flowClassifierId flow classifier id.
         * @return Builder object by setting flow classifier Id.
         */
        Builder setFlowClassifierId(FlowClassifierId flowClassifierId);

        /**
         * Sets Tenant ID.
         *
         * @param tenantId tenant id.
         * @return Builder object by setting Tenant ID.
         */
        Builder setTenantId(TenantId tenantId);

        /**
         * Sets Flow classifier name.
         *
         * @param name flow classifier name
         * @return builder object by setting flow classifier name
         */
        Builder setFlowClassifierName(String name);

        /**
         * Sets flow classifier description.
         *
         * @param description flow classifier description
         * @return flow classifier description
         */
        Builder setFlowClassifierDescription(String description);

        /**
         * Sets Ehternet type.
         *
         * @param etherType ethernet type
         * @return ethernet type
         */
        Builder setEtherType(String etherType);

        /**
         * Sets IP protocol.
         *
         * @param protocol IP protocol
         * @return builder object by setting IP protocol
         */
        Builder setIpProtocol(String protocol);

        /**
         * Set minimum source port range.
         *
         * @param minRange minimum source port range
         * @return builder object by setting minimum source port range
         */
        Builder setMinSrcPortRange(int minRange);

        /**
         * Sets maximum source port range.
         *
         * @param maxRange maximum source port range
         * @return builder object by setting maximum source port range
         */
        Builder setMaxSrcPortRange(int maxRange);

        /**
         * Sets minimum destination port range.
         *
         * @param minRange minimum destination port range
         * @return builder object by setting minimum destination port range
         */
        Builder setMinDstPortRange(int minRange);

        /**
         * Sets maximum destination port range.
         *
         * @param maxRange maximum destination port range.
         * @return builder object by setting maximum destination port range.
         */
        Builder setMaxDstPortRange(int maxRange);

        /**
         * Sets Source IP prefix.
         *
         * @param srcIpPrefix Source IP prefix
         * @return builder object by setting Source IP prefix
         */
        Builder setSrcIpPrefix(IpPrefix srcIpPrefix);

        /**
         * Sets Destination IP prefix.
         *
         * @param dstIpPrefix Destination IP prefix
         * @return builder object by setting Destination IP prefix
         */
        Builder setDstIpPrefix(IpPrefix dstIpPrefix);

        /**
         * Sets Source virtual port.
         *
         * @param srcPort Source virtual port
         * @return builder object by setting Source virtual port
         */
        Builder setSrcVirtualPort(VirtualPortId srcPort);

        /**
         * Sets Destination virtual port.
         *
         * @param dstPort Destination virtual port
         * @return builder object by setting Destination virtual port
         */
        Builder setDstVirtualPort(VirtualPortId dstPort);
    }
}
