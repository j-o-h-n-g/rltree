# contrib/rltree/Makefile

MODULE_big = rltree
OBJS = 	rltree_io.o rltree_op.o rlquery_op.o _rltree_op.o crc32.o \
	rltxtquery_io.o rltxtquery_op.o rltree_gist.o _rltree_gist.o
PG_CPPFLAGS = -DLOWER_NODE

EXTENSION = rltree
DATA = rltree--1.0.sql rltree--unpackaged--1.0.sql

REGRESS = rltree

ifdef USE_PGXS
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
else
subdir = contrib/rltree
top_builddir = ../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif
