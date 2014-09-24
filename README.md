libgossip
=========

Message queueing in Objective-C without Foundation dependency

## install with clibs

```sh
$ [sudo] clib install jwerle/libgossip
```

## building from source

```sh
$ ./configure
$ make
$ make check
$ [sudo] make install
```

## system requirements

* clang
* llvm
* make
* ar
* libnanomsg
* libobjc >= 3
* libBlocksRuntime (Linux only)

## documentation

TODO...

## example

**server.m**

```objc
#import <stdio.h>
#import <gossip.h>

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
```

**client.m**

```objc
#import <stdio.h>
#import <gossip.h>

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
```

### build and run

```sh
$ cc server.m -lgossip -lobjc -o server
$ cc client.m -lgossip -lobjc -o client
$ ./server tcp://*:8888 &
$ ./client tcp://127.0.0.1:8888 HI
connecting to `tcp://127.0.0.1:8888'
sending `HI'
GOT: HI
$ fg
./server tcp://*:8888
^C
```

## license

MIT
