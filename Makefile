#
# Makefile
#
CC = /opt/swi/SWI9X15Y_07.13.05.00/sysroots/x86_64-pokysdk-linux/usr/bin/arm-poky-linux/arm-poky-linux-gcc
CFLAGS = -Wall -Wshadow -Wundef -Wmaybe-uninitialized
CFLAGS +=--sysroot=/opt/swi/SWI9X15Y_07.13.05.00/sysroots/armv7a-neon-poky-linux-gnueabi 
CFLAGS += -O3 -g3 -I./
#LDFLAGS += -lSDL2 -lm
LDFLAGS += --sysroot=/opt/swi/SWI9X15Y_07.13.05.00/sysroots/armv7a-neon-poky-linux-gnueabi 
BIN = demo
VPATH = 

LVGL_DIR = ${shell pwd}

MAINSRC = main.c

#LIBRARIES
include ./lvgl/lv_core/lv_core.mk
include ./lvgl/lv_hal/lv_hal.mk
include ./lvgl/lv_objx/lv_objx.mk
include ./lvgl/lv_fonts/lv_fonts.mk
include ./lvgl/lv_misc/lv_misc.mk
include ./lvgl/lv_themes/lv_themes.mk
include ./lvgl/lv_draw/lv_draw.mk

#DRIVERS
include ./lv_drivers/display/display.mk
include ./lv_drivers/indev/indev.mk

OBJEXT ?= .o

AOBJS = $(ASRCS:.S=$(OBJEXT))
COBJS = $(CSRCS:.c=$(OBJEXT))

MAINOBJ = $(MAINSRC:.c=$(OBJEXT))

SRCS = $(ASRCS) $(CSRCS) $(MAINSRC)
OBJS = $(AOBJS) $(COBJS)

## MAINOBJ -> OBJFILES

all: clean default

%.o: %.c
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo "CC $<"
    
default: $(AOBJS) $(COBJS) $(MAINOBJ)
	$(CC) $(MAINOBJ) $(AOBJS) $(COBJS) $(LDFLAGS) -o $(BIN) 

clean: 
	rm -f $(BIN) $(AOBJS) $(COBJS) $(MAINOBJ)
