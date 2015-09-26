X11LIBDIR = /usr/X11R6/lib
PASCALCOMPILER = fpc
CC = gcc
CFLAGS = -O2 -g

POBJS =	puff.o pfart.o pffft.o pfmsc.o pfrw.o pfst.o pfun1.o pfun2.o pfun3.o xgraph.o

puff:	$(POBJS) puff_c.o ppas.sh
	sed 's/link.res/link.res puff_c.o \/usr\/lib\/libX11.so/' <ppas.sh  >ppasx.sh
	sh ppasx.sh

%.o:	%.pas
	$(PASCALCOMPILER) -g $< -Cn

ppas.sh:	puff.pas
	$(PASCALCOMPILER) -g -s -a -T puff.pas

# version: 20100115

clean:
	rm -rf puff
	rm -rf *.o
	rm -rf *.s
	rm -rf *.ppu
	rm -rf link.res
	rm -rf ppas.sh ppasx.sh
