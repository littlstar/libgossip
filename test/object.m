
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
  [super init];
  _firstName = NULL;
  _lastName = NULL;
  _age = 0;
  return self;
}

@end

int
main (void) {
  Person *joe = [Person new];

  assert(joe);
  assert(NULL == joe.firstName);
  assert(NULL == joe.lastName);
  assert(0 == joe.age);

  joe.firstName = "Joseph";
  joe.lastName = "Werle";
  joe.age = 24;

  assert("Joseph" == joe.firstName);
  assert("Werle" == joe.lastName);
  assert(24 == joe.age);

  return 0;
}

