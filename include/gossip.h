
/**
 * `gossip.h'
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#ifndef GOSSIP_H
#define GOSSIP_H

#if ! __OBJC2__
#error "libgossip needs at least Objective-C 2"
#endif

#include <stdarg.h>
#include <objc/objc.h>

@class GossipObject;
@class GossipSocket;

#define GOSSIP_OBJECT_CLASS_DESCRIPTION "[Class GossipObject]"
#define GOSSIP_OBJECT_RECEIVER_DESCRIPTION "<GossipObject>"

/**
 * `GossipObject' interface protocol
 */

@protocol GossipObjectProtocol

  /**
   * Allocates and returns a new receiver
   */

  + (id) alloc;

  /**
   * Initializes a receiver
   */

  + (id) init;
  - (id) init;

  /**
   * Allocates and returns a new initialized receiver
   */

  + (id) new;

  /**
   * Deallocates a receiver
   */

  + (void) dealloc;
  - (void) dealloc;

  /**
   * Copies a receiver
   */

  + (id) copy;
  - (id) copy;

  /**
   * Finalizes receiver
   */

  + (void) finalize;
  - (void) finalize;

  /**
   * Returns receiver class name
   */

  + (Class) class;
  - (Class) class;

  /**
   * Returns receiver super class
   */

  + (Class) superclass;
  - (Class) superclass;

  /**
   * Returns a boolean indicating whether
   * the receiver and object are equal
   */

  + (BOOL) isEqual: (id) obj;
  - (BOOL) isEqual: (id) obj;

  /**
   * Returns an `unsigned long' hash
   * of receiver
   */

  + (unsigned long) hash;
  - (unsigned long) hash;

  /**
   * Returns receiver
   */

  + (id) self;
  - (id) self;

  /**
   * Returns boolean indicating whether the
   * receiver is a kind of class
   */

  + (BOOL) isKindOfClass: (Class) class;
  - (BOOL) isKindOfClass: (Class) class;

  /**
   * Returns boolean indicating whether the
   * receiver is an instance of class
   */

  + (BOOL) isMemberOfClass: (Class) class;
  - (BOOL) isMemberOfClass: (Class) class;

  /**
   * Returns a boolean indicating whether the
   * receiver can respond to a selector
   */

  + (BOOL) respondsToSelector: (SEL) selector;
  - (BOOL) respondsToSelector: (SEL) selector;

  /**
   * Returns a boolean indicating whether a
   * receiver conforms to a protocol
   */

  + (BOOL) conformsToProtocol: (Protocol *) protocol;
  - (BOOL) conformsToProtocol: (Protocol *) protocol;

  /**
   * Returns a string describing the receiver
   */

  + (unsigned char *) description;
  - (unsigned char *) description;

  /**
   * Sends message to receiver and returns
   * results
   */

  + (id) performSelector: (SEL) selector;
  - (id) performSelector: (SEL) selector;

  /**
   * Sends message with object to receiver and
   * returns results
   */

  + (id) performSelector: (SEL) selector withObject: (id) object;
  - (id) performSelector: (SEL) selector withObject: (id) object;

  /**
   * Sends message with two objects to receiver
   * and returns results
   */

  + (id) performSelector: (SEL) selector withObject: (id) object;
  - (id) performSelector: (SEL) selector withObject: (id) object;

  /**
   * Returns a boolean indicating whether the
   * receiver is a proxy
   */

  + (BOOL) isProxy;
  - (BOOL) isProxy;

  /**
   * Captures forwared messages
   */

  - (id) forward: (SEL) selector : (va_list) args;

  - (id) receive: (SEL) selector : (va_list) args;

@end

/**
 * `GossipObject' interface
 */

@interface GossipObject <GossipObjectProtocol> {
  Class isa;
}
@end

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

