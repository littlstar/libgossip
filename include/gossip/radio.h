
/**
 * `radio.h'
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#ifndef GOSSIP_RADIO_H
#define GOSSIP_RADIO_H

#include <nanomsg/pipeline.h>
#import "common.h"
#import "socket.h"

@interface GossipRadio : GossipSocket

  /**
   * Send a message and receive response
   */

  - (id) radio: (char *) message
       receive: (GossipSocketReceiveBlock) block;

  /**
   * Send a message with size and receive response
   */

  - (id) radio: (char *) message
          size: (size_t) size
       receive: (GossipSocketReceiveBlock) block;


@end

#endif
