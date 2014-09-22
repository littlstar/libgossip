
/**
 * `survey.m'
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#include <string.h>
#include <time.h>
#include <nanomsg/nn.h>
#include <nanomsg/survey.h>

#import "gossip/socket.h"
#import "gossip/survey.h"

@implementation GossipSurvey

  - (id) init {
    [super init];
    domain = AF_SP;
    return self;
  }

  - (id) survey: (const char *) message
         response: (GossipSocketReceiveBlock) block {
    int sent = 0;
    if (protocol != GossipSocket.SURVEYOR) {
      _hasError = YES;
      return self;
    } else if (NO == _isBound) {
      _hasError = YES;
      return self;
    }

    sent = [self send: message size: strlen(message) + 1];
    if (-1 == sent) {
      _hasError = YES;
      return self;
    }

    __block BOOL continueRead = YES;
    __block GossipSocketReceiveBlock cb = block;
    struct timespec tv = { .tv_sec = 0, .tv_nsec = 100000 };
    GossipSocketReceiveBlock onread = ^void (void *data, size_t size) {
      if (ETIMEDOUT == size) {
        continueRead = NO;
        return;
      }
      cb(data, size);
    };

    while (1) {
      nanosleep(&tv, NULL);
      if (NO == continueRead) { break; }
      [self receive: onread size: NN_MSG];
    }

    return self;
  }

  - (id) request: (GossipSocketReceiveBlock) block {
    while (1) {
      [self receive: block size: NN_MSG];
    }
    return self;
  }

  - (int) respond: (const char *) message {
    if (NO == _isConnected) {
      _hasError = YES;
      return -1;
    } else if (protocol != GossipSocket.RESPONDENT) {
      _hasError = YES;
      return -1;
    }
    return [self send: message];
  }

@end
