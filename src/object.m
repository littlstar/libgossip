
/**
 * `object.m' - libgossip
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#pragma GCC diagnostic ignored "-Wobjc-root-class"

#include <objc/objc.h>
#include <objc/runtime.h>
#include <objc/message.h>
#import "gossip/object.h"


// generate hash
#define HASHGEN(o) ((unsigned long) o)

#ifdef __objc_INCLUDE_GNU
#define objc_msgSend
#endif

@implementation GossipObject

  + (id) alloc {
    return (id) class_createInstance(self, 0);
  }

  + (id) init {
    return (id) self;
  }

  - (id) init {
    return (id) self;
  }

  + (id) new {
    // allocate and initialize
    return [[self alloc] init];
  }

  + (void) dealloc { }

  - (void) dealloc {
#ifdef OBJC_IS_TAGGED_PTR
    if (OBJC_IS_TAGGED_PTR((id) self)) return;
#endif
    object_dispose((id) self);
  }

  + (void) doesNotRecognizeSelector: (SEL) selector {
    // @TODO - handle with error
  }

  - (void) doesNotRecognizeSelector: (SEL) selector {
    // @TODO - handle with error
  }

  - (id) forward: (SEL) selector : (va_list) args {
    [self doesNotRecognizeSelector: selector];
    return nil;
  }

  - (id) receive: (SEL) selector : (va_list) args {
    [self doesNotRecognizeSelector: selector];
    return nil;
  }

  + (void) finalize { }
  - (void) finalize { }

  + (id) copy {
    return (id) self;
  }

  - (id) copy {
    return (id) self;
  }

  + (Class) class {
    return self;
  }

  - (Class) class {
    return object_getClass(self);
  }

  + (Class) superclass {
    return class_getSuperclass(self);
  }

  - (Class) superclass {
    return class_getSuperclass([self class]);
  }

  + (BOOL) isEqual: (id) obj {
    return obj == (id) self;
  }

  - (BOOL) isEqual: (id) obj {
    return obj == self;
  }

  + (unsigned long) hash {
    return HASHGEN(self);
  }

  - (unsigned long) hash {
    return HASHGEN(self);
  }

  + (id) self {
    return (id) self;
  }

  - (id) self {
    return self;
  }

  + (BOOL) isKindOfClass: (Class) class {
    // current receives class
    Class this = object_getClass((id) self);

    // traverse tree upward
    for (; this; this = class_getSuperclass(this)) {
      // found
      if (class == this) { return YES; }
    }

    return NO;
  }

  - (BOOL) isKindOfClass: (Class) class {
    // current class
    Class this = [self class];

    // traverse tree upward
    for (; this; this = class_getSuperclass(this)) {
      // found
      if (class == this) { return YES; }
    }

    return NO;
  }

  + (BOOL) isMemberOfClass: (Class) class {
    return class == object_getClass((id) self);
  }

  - (BOOL) isMemberOfClass: (Class) class {
    return class == [self class];
  }

  + (BOOL) respondsToSelector: (SEL) selector {
    if (!selector) { return NO; }
    Class this = object_getClass((id) self);
    return class_respondsToSelector(this, selector);
  }

  - (BOOL) respondsToSelector: (SEL) selector {
    if (0 == selector) return NO;
    Class this = [self class];
    return class_respondsToSelector(this, selector);
  }

  + (BOOL) conformsToProtocol: (Protocol *) protocol {
    if (NULL == protocol) { return NO; }
    // current this
    Class this = self;

    // travserse tree upward
    for (; this; this = class_getSuperclass(this)) {
      if (class_conformsToProtocol(this, protocol)) {
        return YES;
      }
    }

    return NO;
  }

  - (BOOL) conformsToProtocol: (Protocol *) protocol {
    if (NULL == protocol) { return NO; }
    // current this
    Class this = [self class];

    // travserse tree upward
    for (; this; this = class_getSuperclass(this)) {
      if (class_conformsToProtocol(this, protocol)) {
        return YES;
      }
    }

    return NO;
  }

  + (unsigned char *) description {
    return (unsigned char *) GOSSIP_OBJECT_RECEIVER_DESCRIPTION;
  }

  - (unsigned char *) description {
    return (unsigned char *) GOSSIP_OBJECT_CLASS_DESCRIPTION;
  }


  + (id) performSelector: (SEL) selector {
    if (0 == selector) {
      [self doesNotRecognizeSelector: selector];
    }

    return self;
    //return ((id (*) (id, SEL)) objc_msgSend)((id) self, selector);
  }

  - (id) performSelector: (SEL) selector {
    if (0 == selector) {
      [self doesNotRecognizeSelector: selector];
    }

    return self;
    //return ((id (*) (id, SEL)) objc_msgSend)((id) self, selector);
  }

  + (id) performSelector: (SEL) selector withObject: (id) object {
    if (0 == selector) {
      [self doesNotRecognizeSelector: selector];
    }

    return self;
    //return ((id (*) (id, SEL, id)) objc_msgSend)((id) self, selector, object);
  }

  - (id) performSelector: (SEL) selector withObject: (id) object {
    if (0 == selector) {
      [self doesNotRecognizeSelector: selector];
    }

    return self;
    //return ((id (*) (id, SEL, id)) objc_msgSend)((id) self, selector, object);
  }

  + (id) performSelector: (SEL) selector withObject: (id) a withObject: (id) b {
    if (0 == selector) {
      [self doesNotRecognizeSelector: selector];
    }

    return self;
    //return ((id (*) (id, SEL, id, id)) objc_msgSend)((id) self, selector, a, b);
  }

  - (id) performSelector: (SEL) selector withObject: (id) a withObject: (id) b {
    if (0 == selector) {
      [self doesNotRecognizeSelector: selector];
    }

    return self;
    //return ((id (*) (id, SEL, id, id)) objc_msgSend)((id) self, selector, a, b);
  }

  + (BOOL) isProxy {
    return NO;
  }

  - (BOOL) isProxy {
    return NO;
  }

@end

