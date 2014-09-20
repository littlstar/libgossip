
/**
 * `socket.m' - libgossip
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <nanomsg/nn.h>
#include <nanomsg/pipeline.h>

#import "gossip/socket.h"

@implementation GossipSocket : GossipObject
@synthesize domain;
@synthesize protocol;

  + (const char *) Error {
    return nn_strerror(errno);
  }

  + (int) PULL { return NN_PULL; }
  + (int) PUSH { return NN_PUSH; }
  + (int) REQ { return NN_PUSH; }
  + (int) REP { return NN_PULL; }

  - (id) init {
    [super init];

    // state
    _fd = 0;
    domain = 0;
    protocol = 0;

    // predicates
    _isConnected = NO;
    _isBound = NO;
    _hasError = NO;

    return self;
  }

  - (BOOL) hasError { return _hasError; }
  - (BOOL) isConnected { return _isConnected; }
  - (BOOL) isBound { return _isBound; }

  - (id) open {
    _fd = nn_socket(domain, protocol);
    if (-1 == _fd) {
      _hasError = YES;
    }
    return self;
  }

  - (id) close {
    if (0 != _fd) {
      if (0 != nn_close(_fd)) {
        _hasError = YES;
      }
    }

    return self;
  }

  - (id) bind: (const char *) address {
    if (-1 == nn_bind(_fd, address)) {
      _hasError = YES;
    } else {
      _isBound = YES;
    }

    return self;
  }

  - (id) connect: (const char *) address {
    if (-1 == nn_connect(_fd, address)) {
      _hasError = YES;
    } else {
      _isConnected = YES;
    }

    return self;
  }

  - (id) send: (const void *) buffer {
    size_t size = strlen(buffer);
    return [self send: buffer size: size];
  }

  - (id) send: (const void *) buffer size: (size_t) size {
    return [self send: buffer size: size flags: 0];
  }

  - (id) send: (const void *) buffer size: (size_t) size flags: (int) flags {
    if (-1 == nn_send(_fd, buffer, size, flags)) {
      _hasError = YES;
    }
    return self;
  }

  - (id) receive: (GossipSocketReceiveBlock) block {
    return [self receive: block size: BUFSIZ flags: 0];
  }

  - (id) receive: (GossipSocketReceiveBlock) block size: (size_t) size {
    return [self receive: block size: size flags: 0];
  }

  - (id) receive: (GossipSocketReceiveBlock) block size: (size_t) size flags: (int) flags {
    char buf[size];
    size_t nread = nn_recv(_fd, buf, size, flags);
    if (-1 == nread) {
      _hasError = YES;
    } else {
      if (!block) {
        block(buf, nread);
      }
    }

    return self;
  }

  - (BOOL) shutdown {
    if (NO == _isConnected && NO == _isBound) {
      return NO;
    } else if (_hasError) {
      return NO;
    } else if (0 == _eid) {
      return NO;
    } else if (-1 == nn_shutdown(_fd, _eid)) {
      _hasError = YES;
      return NO;
    }

    return YES;
  }

@end
