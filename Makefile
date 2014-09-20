
AR ?= ar
CC ?= cc

VERSION ?= 0.0.1

SRC = $(wildcard src/*.m)
OBJS = $(SRC:.m=.o)

TEST =
TESTS = $(wildcard test/*.m)
TESTSC = $(TESTS:.m=)

TARGET_LIBRAY = libgossip.so

CFLAGS += -Iinclude
CFLAGS += -fPIC
LDFLAGS += -lobjc -lnanomsg
LDFLAGS += -shared -Wl -o $(TARGET_LIBRAY)

ifndef V
BRIEFC = AR CC TEST
-include make/brief.mk
endif

.PHONY: $(OBJS) $(TARGET_LIBRAY) $(TESTS)

all: $(TARGET_LIBRAY)

$(TARGET_LIBRAY): $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS)
	@ln -sf $(TARGET_LIBRAY) $(TARGET_LIBRAY).$(VERSION)

$(OBJS):
	$(CC) $(CFLAGS) -c $(@:.o=.m) -o $(@)

test: $(TESTSC)
$(TESTS): $(TARGET_LIBRAY)
	$(CC) $(@) $(TARGET_LIBRAY) $(CFLAGS) -lobjc -lnanomsg -o $(@:.m=)

$(TESTSC): $(TESTS)
	$(TEST)
	@if [ "test/pipe" == "$(@)" ]; then \
		./$(@) pull & sleep 1; \
		./$(@) push & wait; \
	else \
		./$(@); \
	fi;

clean:
	rm -f $(OBJS)
	rm -f $(wildcard $(TARGET_LIBRAY)*)
	rm -f $(TESTS:.m=)

