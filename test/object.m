
#include <stdio.h>
#include <assert.h>

#import "gossip.h"

@interface Person : GossipObject
@property (assign) char *firstName;
@property (assign) char *lastName;
@property (assign) int age;
@end

@implementation Person : GossipObject
- (id) init {
  _firstName = "";
  _lastName = "";
  //_age = 0;
  return self;
}

@end

int
main (void) {
  Person *joe = [Person new];
  assert(joe);
  joe.firstName = "Joseph";
  joe.lastName = "Werle";
  assert("Joseph" == joe.firstName);
  assert("Werle" == joe.lastName);
  return 0;
}
