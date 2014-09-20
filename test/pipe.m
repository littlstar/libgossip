
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <assert.h>
#import "gossip/pipe.h"

#define MSG "HELLO"

int
test_push (void) {
  GossipPipe *pipe = GossipPipe.new;
  assert(pipe);

  pipe.protocol = GossipSocket.PUSH;
  assert(pipe.protocol == GossipSocket.PUSH);

  [pipe open];
  assert(NO == pipe.hasError);

  [pipe bind: "tcp://*:8888"];
  assert(NO == pipe.hasError);

  [pipe send: MSG];
  assert(NO == pipe.hasError);

  return 0;
}

int
test_pull (void) {
  GossipPipe *pipe = GossipPipe.new;
  assert(pipe);

  pipe.protocol = GossipSocket.PULL;
  assert(pipe.protocol == GossipSocket.PULL);

  [pipe open];
  assert(NO == pipe.hasError);

  [pipe connect: "tcp://localhost:8888"];
  assert(NO == pipe.hasError);

  [pipe receive:^ (void *data, size_t size) {
    char *buf = (char *) data;
    buf[size] = '\0';
    assert(0 == strcmp(buf, MSG));
  }];

  assert(NO == pipe.hasError);

  return 0;
}

int
main (int argc, char **argv) {
  if (1 == argc) { return 1; }
  if (0 == strcmp(argv[1], "push")) {
    return test_push();
  } else if (0 == strcmp(argv[1], "pull")) {
    return test_pull();
  }
  return 0;
}
