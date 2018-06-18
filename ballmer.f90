! File: ballmer.f90
! Generate plot data for the ballmer peak
! and write to a NetCDF file
program genBallmer
use netcdf
implicit none

integer, parameter :: npts=1000                         ! number of data points
character(len=*), parameter :: outfile = "ballmer.nc"   ! file to write data to
real, parameter :: xmax = 0.28                          ! maximum x value 

integer :: i                                            ! loop index       
real :: xpt                                             ! x value
real, dimension(npts+1) :: xvals,yvals                  ! arrays to hold x and y(x) data on [0,0.28]
integer :: ncid, xvarid, yvarid, dimid, r               ! NetCDF ID variables and return code

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

! this function returns data to plot the ballmer peak
! tuned to the interval 0 <= x <= 0.28
function ballmer(x)
  real, intent(in) :: x
  real :: ballmer
  ballmer = -0.042 +.08*(x+.7)**2              &  ! negative y-offset with slow rise as x increases   
            + 1.28 * exp(-(75.0*(x+.022)**2))  &  ! low broad exponential (decreases as BAC increases)
            + 3.14 * exp(-1.20e5*(x-0.134)**2) &  ! high narrow exponential for ballmer peak at 0.134
            - 0.18 * exp(-1.8e3*(x-0.112)**2)  &  ! small exponential to correct curvature
            + .003*sin(271*(x-.02))               ! sin function to add waviness
end function ballmer

end program genBallmer
