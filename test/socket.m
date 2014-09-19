
#include <stdio.h>
#include <nanomsg/nn.h>
#include <nanomsg/pipeline.h>
#include <assert.h>

#import "gossip.h"

int
main (void) {
  GossipSocket *socket = [GossipSocket new];
  assert(socket);
  assert(0 == socket.fd);
  assert(0 == socket.domain);
  assert(0 == socket.protocol);

  socket.domain = AF_SP;
  socket.protocol = NN_PULL;
  [socket open];
  return 0;
}
