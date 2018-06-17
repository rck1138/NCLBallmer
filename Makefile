FC = ifort
FFLAGS = -O2
LDFLAGS = ${FFLAGS}

plot: ballmer.png

ballmer.png: ballmer.f90 ballmer.nc ballmer.ncl
	ncl ballmer.ncl

ballmer.nc: mkBallmer
	./mkBallmer

mkBallmer: ballmer.o
	$(FC) -o mkBallmer $(LDFLAGS) ballmer.o

%.o: %.f90
	$(FC) -c $(FFLAGS) $<

clean:
	rm -rf mkBallmer *.o ballmer.nc ballmer.png
 
