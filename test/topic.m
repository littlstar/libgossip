
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <assert.h>
#include "gossip/topic.h"

#define EXCHANGE "tcp://127.0.0.1:8888"
#define HOST "tcp://*:8888"
#define MSG "HELLO TOPIC"

int
test_server (void) {
  GossipTopic *server = GossipTopic.new;
  assert(server);
  server.protocol = GossipSocket.PUB;

  [server open];
  assert(NO == server.hasError);

  [server bind: HOST];
  assert(NO == server.hasError);

  // broadcast
  while (1) {
    assert(NO == server.hasError);
    [server publish: MSG];
  }

  return 0;
}

int
test_client (void) {
  GossipTopic *client = GossipTopic.new;
  assert(client);
  assert(NO == client.hasError);

  client.protocol = GossipSocket.SUB;
  assert(NO == client.hasError);

  [client open];
  assert(NO == client.hasError);

  [client connect: EXCHANGE];
  assert(NO == client.hasError);

  [client subscribe:^ (void *data, size_t size) {
    char *buf = (char *) data;
    assert(data);
    assert(size);
    buf[size] = 0;
    assert(0 == strcmp(buf, MSG));
    exit(0);
  }];

  assert(NO == client.hasError);

  return 0;
}

int
main (int argc, char **argv) {
  if (1 == argc) { return 1; }
  if (0 == strcmp(argv[1], "server")) {
    return test_server();
  } else if (0 == strcmp(argv[1], "client")) {
    return test_client();
  }
  return 0;
}

