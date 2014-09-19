
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
    return self;
  }

  - (id) open {
    _fd = nn_socket(_domain, _protocol);
    if (-1 == _fd) {
      perror("[GossipSocket open]");
      // @TODO - handle with error
    }
    return self;
  }

  - (id) close {
    if (0 != _fd) {
      if (0 != nn_close(_fd)) {
        // @TODO - handle with error
      }
    }

    return self;
  }

  - (id) bind: (const char *) address {
    if (-1 == nn_bind(_fd, address)) {
      // @TODO - handle with error
    }

    return self;
  }

  - (id) connect: (const char *) address {
    if (-1 == nn_connect(_fd, address)) {
      // @TODO - handle with error
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
      // @TODO - handle with error
    }
    return self;
  }

@end
