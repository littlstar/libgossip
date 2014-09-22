
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <assert.h>
#include "gossip/survey.h"

#define HOST "tcp://127.0.0.1:8888"

int
test_server (void) {
  GossipSurvey *server = GossipSurvey.new;
  assert(server);
  assert(NO == server.hasError);

  server.protocol = GossipSocket.SURVEYOR;
  assert(NO == server.hasError);

  [server open];
  assert(NO == server.hasError);

  [server bind: HOST];
  assert(NO == server.hasError);

  // wait for connections
  sleep(2);

  __block int min = 5;
  __block int count = 0;
  [server survey: "ID" response:^ (void *data, size_t size) {
    assert(NO == server.hasError);
    if (count++ >= min) { exit(0); }
    assert(data);
    assert(size);
  }];

  assert(NO == server.hasError);

  return 0;
}

int
test_client (void) {
  GossipSurvey *client = GossipSurvey.new;
  assert(client);
  assert(NO == client.hasError);

  client.protocol = GossipSocket.RESPONDENT;

  [client open];
  assert(NO == client.hasError);

  [client connect: HOST];
  assert(NO == client.hasError);

  [client request:^ (void *data, size_t size) {
    assert(NO == client.hasError);
    assert([client respond: (char *) (unsigned long) client]);
    exit(0);
  }];

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
