
/**
 * `topic.m'
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#include <string.h>
#include <time.h>
#include <nanomsg/nn.h>
#include <nanomsg/pubsub.h>
#import "gossip/socket.h"
#import "gossip/topic.h"

@implementation GossipTopic

  - (id) init {
    [super init];
    domain = AF_SP;
    return self;
  }

  - (id) open {
    [super open];

    if (protocol == GossipSocket.SUB) {
      if (-1 == nn_setsockopt (_fd, NN_SUB, NN_SUB_SUBSCRIBE, "", 0)) {
        _hasError = YES;
      }
    }

    return self;
  }

  - (id) subscribe: (GossipSocketReceiveBlock) block {
    if (NO == _isConnected) {
      _hasError = YES;
      return self;
    } else if (protocol != GossipSocket.SUB) {
      _hasError = YES;
      return self;
    }

    struct timespec tv = { .tv_sec = 0, .tv_nsec = 1000 };
    while (1) {
      // receive message
      [self receive: block size: NN_MSG];
      // rest
      nanosleep(&tv, NULL);
      if (YES == _hasError && errno == ETIMEDOUT) {
        _hasError = NO;
      }

    }
    return self;
  }

  - (int) publish: (const char *) message {
    return [self publish: message size: strlen(message) + 1];
  }

  - (int) publish: (const char *) message size: (size_t) size {
    if (NO == _isBound) {
      _hasError = YES;
      return -1;
    } else if (protocol != GossipSocket.PUB) {
      _hasError = YES;
      return -1;
    }
    return [self send: message size: size];
  }

@end

