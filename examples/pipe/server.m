
#import <stdio.h>
#import <gossip.h>

//
// $ make
// $ ./server tcp://*:8888
//

int
main (int argc, char **argv) {
  if (argc == 1) { return 1; }
  GossipPipe *pipe = GossipPipe.new;
  pipe.protocol = GossipSocket.PULL;
  [pipe open];
  [pipe bind: argv[1]];
  while (1) {
    [pipe pull: ^(void *data, size_t size) {
      char *buf = (char *) data;
      buf[size] = 0;
      printf("GOT: %s\n", buf);
    }];
    [pipe close];
  }
  return 0;
}
