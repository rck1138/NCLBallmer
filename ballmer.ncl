; ***********************************************
; ballmer.ncl
;
; Gernerates a plot of the Ballmer Peak.
;
begin
;************************************************
; read in data
;************************************************
 f     = addfile ("ballmer.nc","r")
 x     = f->xvals                                    ; get u data
 y     = f->yvals
;************************************************
; plotting parameters
;************************************************
 wks   = gsn_open_wks ("png","ballmer")               ; send graphics to PNG file

 res                   = True                        ; plot mods desired
 res@vpHeightF         = 0.45
 res@vpWidthF          = 0.75         
 res@vpXF              = 0.14
 res@trXMaxF           = 0.35
 res@xyLineColors      = (/"red"/)                   ; line color
 res@xyLineThicknesses = (/4.0/)
 res@tiYAxisString     = "Programming Skill"         ; y-axis label
 res@tiXAxisString     = "BAC (%)"                   ; x-axis label
 res@tiMainString      = "The Ballmer Peak"          ; add title

 plot  = gsn_csm_xy (wks,x,y,res) ; create plot
end
