
#include <stdio.h>
#include <objc/runtime.h>
#include <nanomsg/nn.h>
#include <assert.h>

#import "gossip.h"

int
main (void) {
  GossipSocket *socket = [GossipSocket new];
  assert(socket);
  socket.fd = 1234;
  printf("%d\n", socket.fd);
  return 0;
}
