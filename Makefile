TARGET = example.exe

INCLUDE = -I./include

SRCDIR = src
SRCS = main.c
SRCS += example.c

OBJDIR = obj
OBJS = $(addprefix $(OBJDIR)/,$(SRCS:.c=.o))

DEPS = $(addprefix $(OBJDIR)/,$(SRCS:.c=.d))

CC = gcc
CFLAGS = -Wall -Wextra -Werror -std=c23
CFLAGS += -MMD -MP
LDFLAGS = -lc

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	mkdir -p $(OBJDIR)
	$(CC) $(INCLUDE) $(CFLAGS) -o $@ -c $<

-include $(DEPS)

clean:
	rm -f $(OBJS) $(DEPS)

fclean: clean
	rm -f $(TARGET)

re: fclean all

asan: CFLAGS += -fsanitize=address
asan: LDFLAGS += -fsanitize=address
asan: re

valgrind: $(TARGET)
	valgrind --leak-check=full ./$(TARGET) -v localhost

debug: CFLAGS += -g -DDEBUG
debug: re

.PHONY: all clean fclean re valgrind debug
