AUXFILES := ADDONS.LAT UNIQUES.LAT

GENFILES := DICTFILE.GEN STEMFILE.GEN INDXFILE.GEN EWDSFILE.GEN EWDSLIST.GEN INFLECTS.SEC CHECKEWD.

BINARIES := words makedict makestem makeewds makeefil makeinfl

OBJECTS := *.o *.ali

.PHONY: all clean

GNATMAKE := gnatmake

all: words $(GENFILES) $(AUXFILES)

words:
	$(GNATMAKE) -O3 words

makedict:
	$(GNATMAKE) makedict

makestem:
	$(GNATMAKE) makestem

makeewds:
	$(GNATMAKE) makeewds

makeefil:
	$(GNATMAKE) makeefil

makeinfl:
	$(GNATMAKE) makeinfl

DICTFILE.GEN: makedict DICTLINE.GEN
	echo g | ./makedict DICTLINE.GEN

STEMFILE.GEN INDXFILE.GEN: makestem STEMLIST.GEN
	echo g | ./makestem STEMLIST.GEN

EWDSLIST.GEN: makeewds DICTLINE.GEN
	echo g | ./makeewds DICTLINE.GEN

EWDSFILE.GEN: makeefil EWDSLIST.GEN
	./makeefil EWSLIST.GEN

INFLECTS.SEC: makeinfl INFLECTS.LAT
	./makeinfl INFLECTS.LAT

clean:
	rm -f $(GENFILES) $(BINARIES) $(OBJECTS)
