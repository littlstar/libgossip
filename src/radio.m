
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
    _loopBlockCount = 0;
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
      .tv_sec = 0, .tv_nsec = 100
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
      [self send: message size: size];
      // ignore timeouts
      if (YES == _hasError && errno == ETIMEDOUT) {
        _hasError = NO;
      }
      {
        for (int i = 0; i < _loopBlockCount; ++i) {
          if (_loopBlocks[i]) {
            _loopBlocks[i]();
          }
        }
      }
    }

    return self;
  }

  - (id) loop: (GossipRadioLoopBlock) block {
    if (nil != block) {
      _loopBlocks[_loopBlockCount++] = block;
    }
    return self;
  }

@end
