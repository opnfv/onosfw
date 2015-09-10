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

package org.onosproject.pcepio.protocol;

import org.jboss.netty.buffer.ChannelBuffer;
import org.onosproject.pcepio.exceptions.PcepParseException;

/**
 * Abstraction of an entity providing PCEP FEC Object.
 */
public interface PcepFecObject {

    /**
     * Returns PCEP Version of FEC Object.
     *
     * @return PCEP Version of FEC Object
     */
    PcepVersion getVersion();

    /**
     * Returns FEC Object type.
     *
     * @return FEC Object type
     */
    int getType();

    /**
     * Writes the FEC into channel buffer.
     *
     * @param bb channel buffer
     * @return Returns the writerIndex of this buffer
     * @throws PcepParseException while writing FEC Object into Channel Buffer.
     */
    int write(ChannelBuffer bb) throws PcepParseException;
}
