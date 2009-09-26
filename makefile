PREFIX=.
SRC_PATH=src
TEST_PATH=tests
INCLUDE_PATH=$(PREFIX)/include
LIB_PATH=$(PREFIX)/lib
EXTERNAL_LIBS=$(PREFIX)/external-libs

PATH_TO_GL=/usr
GL_INCLUDE=$(PATH_TO_GL)/include/GL
GL_LIB=$(PATH_TO_GL)/lib

INCLUDE_FILES=opengl_.scm glu_.scm glut_.scm
LIB_FILES=opengl.o1 glu.o1 glut.o1

CCOPTS=-I$(GL_INCLUDE)
LDOPTS=-L$(GL_LIB) -lglut

all: prefix include lib

prefix:
ifneq "$(PREFIX)" "."
	mkdir -p $(PREFIX)
endif

include: $(foreach f,$(INCLUDE_FILES),$(INCLUDE_PATH)/$(f))
$(INCLUDE_PATH)/%.scm: $(SRC_PATH)/%.scm
	mkdir -p $(INCLUDE_PATH)
	cp $< $@

lib: $(foreach f,$(LIB_FILES),$(LIB_PATH)/$(f))
$(LIB_PATH)/%.o1: $(SRC_PATH)/%.scm
	mkdir -p $(LIB_PATH)
	gsc -cc-options "$(CCOPTS)/" -ld-options "$(LDOPTS)" -o $@ $<

clean:
	rm -rf include lib
