
/**
 * `radio.m' - libgossip
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#include <string.h>
#include <errno.h>
#include <time.h>
#include <nanomsg/nn.h>
#include <nanomsg/pair.h>
#import "gossip/radio.h"

@implementation GossipRadio

  - (id) init {
    [super init];
    domain = AF_SP;
    protocol = NN_PAIR;
    return self;
  }

  - (id) radio: (char *) message
       receive: (GossipSocketReceiveBlock) block {
    return [self radio: message size: strlen(message) + 1 receive: block ];
  }

  - (id) radio: (char *) message
          size: (size_t) size
       receive: (GossipSocketReceiveBlock) block {
    int to = 100; // timeout
    struct timespec tv = {
      .tv_sec = 0, .tv_nsec = 1000
    };

    if (NO == _isConnected && NO == _isBound) {
      // must be connected or bound to address
      _hasError = YES;
      return self;
    }
    if (0 != nn_setsockopt (_fd, NN_SOL_SOCKET, NN_RCVTIMEO, &to, sizeof(to))) {
      _hasError = YES;
      return self;
    }

    while (1) {
      // receive message
      [self receive: block size: NN_MSG];
      // rest
      nanosleep(&tv, NULL);
      // send response
      [self send: message size: size + 1];
    }

    return self;
  }

@end
