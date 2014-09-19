
#include <stdio.h>
#include <objc/runtime.h>
#include <nanomsg/nn.h>
#include <assert.h>

#import "gossip.h"

int
main (void) {
  GossipSocket *socket = [GossipSocket new];
  assert(socket);
  assert(0 == socket.fd);
  assert(0 == socket.domain);
  assert(0 == socket.protocol);
  return 0;
}
