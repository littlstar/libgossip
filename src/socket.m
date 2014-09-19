
/**
 * `object.m' - libgossip
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

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
@end
