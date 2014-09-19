
AR ?= ar
CC ?= cc

VERSION ?= 0.0.1

SRC = $(wildcard src/*.m)
OBJS = $(SRC:.m=.o)

TEST = cc
TESTS = $(wildcard test/*.m)

TARGET_LIBRAY = libgossip.so

CFLAGS += -Iinclude
LDFLAGS += -lobjc
LDFLAGS += -shared -Wl -o $(TARGET_LIBRAY)

ifndef V
BRIEFC = AR CC TEST
-include make/brief.mk
endif

.PHONY: $(OBJS) $(TARGET_LIBRAY) $(TESTS)

all: $(TARGET_LIBRAY) $(TESTS)

$(TARGET_LIBRAY): $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS)
	@ln -sf $(TARGET_LIBRAY) $(TARGET_LIBRAY).$(VERSION)

$(OBJS):
	$(CC) $(CFLAGS) -c $(@:.o=.m) -o $(@)

test: $(TESTS)
$(TESTS): $(TARGET_LIBRAY)
	$(TEST) $(CFLAGS) -lobjc $(TARGET_LIBRAY) $(@) -o $(@:.m=)
	@./$(@:.m=)

clean:
	rm -f $(OBJS)
	rm -f $(wildcard $(TARGET_LIBRAY)*)
	rm -f $(TESTS:.m=)

