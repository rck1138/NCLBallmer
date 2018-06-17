! File: ballmer.f90
! Generate plot data for the ballmer peak
! and write to a NetCDF file
program genBallmer
use netcdf
implicit none

integer, parameter :: npts=314
character(len=*), parameter :: outfile = "ballmer.nc"
real, parameter :: xmax = 0.35
integer :: i
real :: xpt
real, dimension(npts+1) :: xvals,yvals
integer :: ncid, xvarid, yvarid, dimid, r

! generate data on the ballmer peak
print *, "Generating data for Ballmer Peak"
xpt = 0.0
do i=1,npts+1
  xvals(i) = xpt
  yvals(i) = ballmer(xpt)
  xpt = xpt + xmax/npts
end do

! write data to NetCDF file
r=nf90_create(outfile, NF90_CLOBBER, ncid) 
r=nf90_def_dim(ncid, "x", npts+1, dimid) 
r=nf90_def_var(ncid, "xvals", NF90_FLOAT, (/dimid/), xvarid) 
r=nf90_def_var(ncid, "yvals", NF90_FLOAT, (/dimid/), yvarid)
r=nf90_enddef(ncid) 
r=nf90_put_var(ncid, xvarid, xvals)
r=nf90_put_var(ncid, yvarid, yvals) 
r=nf90_close(ncid) 

print *, "Data written to " // trim(outfile)


contains

function ballmer(x)
  real, intent(in) :: x
  real :: ballmer
  ballmer = 0.03 + 0.97*exp(-(66.0*x*x)) + 2.6 * exp(-1.0e5*((x-0.134)**2))
end function ballmer

end program genBallmer
