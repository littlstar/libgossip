
/**
 * `object.m' - libgossip
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#include <stdio.h>
#include <string.h>
#include <nanomsg/nn.h>

#import "gossip.h"

@implementation GossipSocket : GossipObject
  - (id) init {
    [super init];
    _fd = 0;
    _domain = 0;
    _protocol = 0;
    _isConnected = NO;
    _isBound = NO;
    return self;
  }

  - (id) open {
    _fd = nn_socket(_domain, _protocol);
    if (-1 == _fd) {
      perror("[GossipSocket open]");
      _errno = _fd;
      // @TODO - handle with error
    }
    return self;
  }

  - (id) close {
    if (0 != _fd) {
      if (0 != nn_close(_fd)) {
        perror("[GossipSocket close]");
        // @TODO - handle with error
      }
    }

    return self;
  }

  - (id) bind: (const char *) address {
    if (-1 == nn_bind(_fd, address)) {
      perror("[GossipSocket bind]");
      // @TODO - handle with error
    } else {
      _isBound = YES;
    }

    return self;
  }

  - (id) connect: (const char *) address {
    if (-1 == nn_connect(_fd, address)) {
      perror("[GossipSocket connect]");
      // @TODO - handle with error
    } else {
      _isConnected = YES;
    }

    return self;
  }

  - (id) send: (const char *) buffer {
    size_t size = strlen(buffer);
    return [self send: buffer size: size];
  }

  - (id) send: (const char *) buffer size: (size_t) size {
    return [self send: buffer size: size flags: 0];
  }

  - (id) send: (const char *) buffer size: (size_t) size flags: (int) flags {
    if (-1 == nn_send(_fd, buffer, size, flags)) {
      perror("[GossipSocket send]");
      // @TODO - handle with error
    }
    return self;
  }

@end
