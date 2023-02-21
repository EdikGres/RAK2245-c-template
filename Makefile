APP_NAME := sx1301

LGW_PATH ?= loragw/libloragw


ARCH = arm
CROSS_COMPILE = arm-linux-gnueabihf-

export ARCH
export CROSS_COMPILE

include $(LGW_PATH)/library.cfg

CC := $(CROSS_COMPILE)gcc
AR := $(CROSS_COMPILE)ar
CXX := $(CROSS_COMPILE)g++

CFLAGS=-O2 -Wall -Wextra -std=c99 -Iinc -I.
CXXFLAGS=-O2 -Wall -Wextra -std=c++20 -Iinc -I.

OBJDIR = obj

LGW_INC = $(LGW_PATH)/inc/config.h
LGW_INC += $(LGW_PATH)/inc/loragw_reg.h
LGW_INC += $(LGW_PATH)/inc/loragw_fpga.h

LIBS := -lloragw -lrt -lm

all: $(APP_NAME) 
		

clean: 
	rm -f $(OBJDIR)/*.o
	rm -f $(APP_NAME)
	$(MAKE) clean -e -C $(LGW_PATH)

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(OBJDIR)/$(APP_NAME).o: src/$(APP_NAME).c | $(OBJDIR)
	$(MAKE) all -e -C $(LGW_PATH)
	$(CC) -c $(CFLAGS) -I$(LGW_PATH)/inc $< -o $@
	

$(APP_NAME): $(OBJDIR)/$(APP_NAME).o
	$(CC) -L$(LGW_PATH) $< -o $@ $(LIBS)
