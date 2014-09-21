
/**
 * `object.h'
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#ifndef GOSSIP_OBJECT_H
#define GOSSIP_OBJECT_H

#include <stdarg.h>
#include <objc/objc.h>

#import "common.h"

#define GOSSIP_OBJECT_CLASS_DESCRIPTION "[Class GossipObject]"
#define GOSSIP_OBJECT_RECEIVER_DESCRIPTION "<GossipObject>"

/**
 * `GossipObject' interface protocol
 */

GOSSIP_EXPORT
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

  + (id) performSelector: (SEL) selector
              withObject: (id) object;
  - (id) performSelector: (SEL) selector
              withObject: (id) object;

  /**
   * Sends message with two objects to receiver
   * and returns results
   */

  + (id) performSelector: (SEL) selector
              withObject: (id) a
              withObject: (id) b;
  - (id) performSelector: (SEL) selector
              withObject: (id) a
              withObject: (id) b;

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

@end

/**
 * `GossipObject' interface
 */

GOSSIP_EXPORT
@interface GossipObject <GossipObjectProtocol> {
  Class isa;
}
@end

#endif
