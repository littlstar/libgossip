
#import <stdio.h>
#import <string.h>
#import <unistd.h>
#import <gossip.h>

#import "pool.h"


static char *
FROM_NOTIFY (const char *msg) {
  char *tmp = (char *) strdup(msg);
  int i = 0;
  while ((i++) <= NOTIFY_HEADER_LENGTH) tmp++;
  return tmp;
}

static char *
PARSE_ADDR (const char *addr) {
  char *tmp = nil;
  char host[64];
  char proto[16];
  int port;
  sscanf(addr, "tcp://%[^:]:%99d", host, &port);
  if ('*' == host[0]) {
    asprintf(&tmp, "tcp://%s:%d", "localhost", port);
  } else {
    asprintf(&tmp, "tcp://%s:%d", host, port);
  }
  return tmp;
}

GossipPipe *server = nil;
size_t poolCount = 0;
char *pool[MAX_POOL];

void
init (const char *addr) {
  server = GossipPipe.new;
  server.protocol = GossipSocket.PULL;
  [server open];
  [server bind: addr];
}

void
discover (void) {
  while (1) {
    [server pull: ^(void *data, size_t size) {
      char *buf = nil;
      char *res = nil;
      char *nodeAddress = nil;
      // ignore empty buffers
      if (nil == data || 0 == size) { return; }
      buf = (char *) data;
      buf[size] = 0;
      // check if message is notification for join
      if (0 == strncmp(NOTIFY_HEADER, buf, NOTIFY_HEADER_LENGTH)) {
        nodeAddress = PARSE_ADDR(FROM_NOTIFY(buf));
        do {
          for (int n = 0; n < poolCount; ++n) {
            if (0 == strcmp(pool[n], nodeAddress)) {
              goto found;
            }
          }
          printf("join: %s\n", nodeAddress);
          pool[poolCount++] = nodeAddress;
found:
          (void) nodeAddress;
        } while (0);
      }

      if (poolCount > 1) {
        printf("gossiping about node\n");
      }

      for (int i = 0; i < poolCount; ++i) {
        for (int j = 0; j < poolCount; ++j) {
          if (0 != strcmp(pool[j], pool[i])) {
            printf("\n");
            printf("broadcast: %s\n", pool[i]);
            GossipPipe *node = GossipPipe.new;
            ECHECK(node);

            node.protocol = GossipSocket.PUSH;
            ECHECK(node);

            printf("open: %s\n", pool[j]);
            [node open];
            ECHECK(node);

            printf("connect: %s\n", pool[j]);
            [node connect: pool[j]];
            ECHECK(node);

            printf("push: %s\n", pool[i]);
            [node push: pool[i]];
            ECHECK(node);
          }

        }
      }
    }];
  }
}

int
main (int argc, char **argv) {
  if (argc < 2) { return 1; }

  init(argv[1]);
  sleep(1);
  discover();

  return 0;
}
