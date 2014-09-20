
#include <stdio.h>
#include <assert.h>

#import "gossip.h"
#import "gossip/object.h"

@interface Person : GossipObject {
  char *firstName;
  char *lastName;
  int age;
}

@property (assign) char *firstName;
@property (assign) char *lastName;
@property (assign) int age;

@end

@implementation Person : GossipObject
@synthesize firstName;
@synthesize lastName;
@synthesize age;

- (id) init {
  [super init];
  firstName = NULL;
  lastName = NULL;
  age = 0;
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

