
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#import "gossip/radio.h"

#define MSG "HELLO RADIO"
#define BRIDGE "tcp://127.0.0.1:8888"

// server
int
test_node0 (void) {
  GossipRadio *node0 = GossipRadio.new;
  assert(node0);

  [node0 open];
  assert(NO == node0.hasError);

  [node0 bind: BRIDGE];
  assert(NO == node0.hasError);

  [node0 loop:^ (void) {
    assert(NO == node0.hasError);
    exit(0);
  }];

  [node0 radio: MSG receive:^ (void *data, size_t size) {
    char *buf = (char *) data;
    assert(data);
    assert(buf);
    assert(size);
    assert(0 == strncmp(buf, MSG, size));
  }];

  assert(NO == node0.hasError);
  return 0;
}

// client
int
test_node1 (void) {
  GossipRadio *node1 = GossipRadio.new;
  assert(node1);

  [node1 open];
  assert(NO == node1.hasError);

  [node1 connect: BRIDGE];
  assert(NO == node1.hasError);

  [node1 loop:^ (void) {
    assert(NO == node1.hasError);
    exit(0);
  }];

  [node1 radio: MSG receive:^ (void *data, size_t size) {
    char *buf = (char *) data;
    assert(data);
    assert(buf);
    assert(size);
    buf[size] = 0;
    assert(0 == strncmp(buf, MSG, size));
  }];

  assert(NO == node1.hasError);

  return 0;
}

int
main (int argc, char **argv) {
  if (1 == argc) { return 1; }
  if (0 == strcmp(argv[1], "node0")) {
    return test_node0();
  } else if (0 == strcmp(argv[1], "node1")) {
    return test_node1();
  }
  return 0;
}
