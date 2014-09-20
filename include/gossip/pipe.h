
/**
 * `pipe.h'
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#include <nanomsg/nn.h>
#include <nanomsg/pipeline.h>
#import "common.h"
#import "socket.h"

@interface GossipPipe : GossipSocket

  /**
   * Push a string message to pipe
   */

  - (id) push: (char *) message;

  /**
   * Push a message with size to pipe
   */

  - (id) push: (void *) message
         size: (size_t) size;

  - (id) pull: (GossipSocketReceiveBlock) block;

@end
