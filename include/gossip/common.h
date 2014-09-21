
/**
 * `common.h'
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#ifndef GOSSIP_COMMON_H
#define GOSSIP_COMMON_H

#include <objc/objc.h>
#include <objc/message.h>
#include <objc/runtime.h>
#include <nanomsg/nn.h>

#if __GNUC__ >= 4
# define GOSSIP_EXPORT __attribute__((visibility("default")))
#else
# define GOSSIP_EXPORT
#endif

/*#if ! __OBJC2__
#error "libgossip needs at least Objective-C 2"
#endif*/

#endif
