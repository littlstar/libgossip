
/**
 * `topic.h'
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#ifndef GOSSIP_TOPIC_H
#define GOSSIP_TOPIC_H

#import "common.h"
#import "socket.h"

@interface GossipTopic : GossipSocket

  /**
   * Subscribes to topic calling block for
   * each message received
   */

  - (id) subscribe: (GossipSocketReceiveBlock) block;

  /**
   * Publishes message to topic
   */

  - (int) publish: (const char *) message;

  /**
   * Publishes message with size
   */

  - (int) publish: (const char *) message size: (size_t) size;

@end

#endif
