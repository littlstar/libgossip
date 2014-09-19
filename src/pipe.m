
/**
 * `pipe.m' - libgossip
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#include <string.h>
#include <errno.h>
#include <nanomsg/nn.h>

#import "gossip/pipe.h"

@implementation GossipPipe

  - (id) push: (char *) message {
    int size = strlen(message) + 1; // +1 for '/0'
    return [self push: message size: size];
  }

  - (id) push: (void *) message size: (size_t) size {
    if (NO == [super isConnected]) {
      // @TODO - handle with error messages
      _hasError = YES;
      return self;
    }

    if (NN_PUSH != self.protocol) {
      // @TODO - handle with error messages
      _hasError = YES;
      return self;
    }

    return [self send: message size: size];
  }

  - (id) pull: (GossipSocketReceiveBlock) block {
    if (NO == [super isBound]) {
      // @TODO - handle with error messages
      _hasError = YES;
      return self;
    }

    if (NN_PULL != self.protocol) {
      // @TODO - handle with error messages
      _hasError = YES;
      return self;
    }

    return [self receive: block size: NN_MSG];
  }

@end

