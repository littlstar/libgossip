
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

    // state
    _fd = 0;
    _domain = 0;
    _protocol = 0;

    // predicates
    _isConnected = NO;
    _isBound = NO;
    _hasError = NO;

    return self;
  }

  - (id) open {
    _fd = nn_socket(_domain, _protocol);
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

  - (id) send: (const char *) buffer {
    size_t size = strlen(buffer);
    return [self send: buffer size: size];
  }

  - (id) send: (const char *) buffer size: (size_t) size {
    return [self send: buffer size: size flags: 0];
  }

  - (id) send: (const char *) buffer size: (size_t) size flags: (int) flags {
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
      if (nil != block) {
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
