
#import <stdio.h>
#import <string.h>
#import <gossip.h>

#import "pool.h"

static inline char *
MESSAGE (const char *msg) {
  char *tmp = NULL;
  asprintf(&tmp, "%s%s", NOTIFY_HEADER, msg);
  return tmp;
}

GossipPipe *node = nil;
GossipPipe *server = nil;

char *pool[MAX_POOL];
int poolCount = 0;

void
init (const char *host, const char *addr) {

  // init node
  node = GossipPipe.new;
  node.protocol = GossipSocket.PUSH;

  [node open];
  [node connect: host];

  // init server
  server = GossipPipe.new;
  server.protocol = GossipSocket.PULL;

  [server open];
  [server bind: addr];

  [node push: MESSAGE(addr)];
  while (1) {
    [server pull: ^(void *res, size_t reslen) {
      char *buf = (char *) res;
      buf[reslen] = 0;
      do {
        for (int i = 0; i < poolCount; ++i) {
          if (0 == strcmp(buf, pool[i])) {
            goto found;
          }
        }
        printf("peer: %s\n", buf);
        pool[poolCount++] = buf;
found:
        (void) buf;
      } while (0);

    }];
  }
}

int
main (int argc, char **argv) {
  if (argc < 3) { return 1; }
  init(argv[1], argv[2]);
  return 0;
}
