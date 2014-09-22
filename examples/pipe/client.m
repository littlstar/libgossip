
#import <stdio.h>
#import <gossip.h>

//
// $ make
// $ ./client tcp://127.0.0.1:8888
//

int
main (int argc, char **argv) {
  if (3 != argc) { return 1; }
  GossipPipe *pipe = GossipPipe.new;
  pipe.protocol = GossipSocket.PUSH;
  [pipe open];
  printf("connecting to `%s'\n", argv[1]);
  [pipe connect: argv[1]];
  printf("sending `%s'\n", argv[2]);
  [pipe push: argv[2]];
  [pipe close];
  return 0;
}
