
/**
 * `socket.h'
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#ifndef GOSSIP_SOCKET_H
#define GOSSIP_SOCKET_H

#import "object.h"

typedef void (^GossipSocketReceiveBlock)(void *, size_t);

/**
 * `GossipSocket' interface
 */

@interface GossipSocket : GossipObject <GossipObjectProtocol>
@property (nonatomic) int domain;
@property (nonatomic) int protocol;
@property (nonatomic, readonly) int eid;
@property (nonatomic, readonly) int fd;
@property (nonatomic, readonly) BOOL hasError;
@property (nonatomic, readonly) BOOL isConnected;
@property (nonatomic, readonly) BOOL isBound;

  /**
   * Returns error string for socket
   */

  + (const char *) Error;

  /**
   * Open socket
   */

  - (id) open;

  /**
   * Close socket
   */

  - (id) close;

  /**
   * Bind socket to address
   */

  - (id) bind: (const char *) address;

  /**
   * Connect socket to address
   */

  - (id) connect: (const char *) address;

  /**
   * Send buffer
   */

  - (id) send: (const char *) buffer;

  /**
   * Send buffer with size
   */

  - (id) send: (const char *) buffer
         size: (size_t) size;

  /**
   * Send buffer with size and flags
   */

  - (id) send: (const char *) buffer
         size: (size_t) size
        flags: (int) flags;

  /**
   * Receives a message calling block
   */

  - (id) receive: (GossipSocketReceiveBlock) block;

  /**
   * Receives a message with size calling block
   */

  - (id) receive: (GossipSocketReceiveBlock) block
            size: (size_t) size;

  /**
   * Receives a message with size calling block
   */

  - (id) receive: (GossipSocketReceiveBlock) block
            size: (size_t) size
           flags: (int) flags;

  /**
   * Shuts down an open socket
   */

  - (BOOL) shutdown;

@end

#endif
