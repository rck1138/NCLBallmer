; ***********************************************
; ballmer.ncl
;
; Gernerates a plot of the Ballmer Peak
;
begin
;************************************************
; read in data
;************************************************
 f     = addfile ("ballmer.nc","r")  
 x     = f->xvals                                              ; get data
 y     = f->yvals
;************************************************
; plotting parameters
;************************************************
 wks   = gsn_open_wks ("png","ballmer")                        ; send graphics "ballmer.png"
 res                      = True                               ; plot resources
 res@vpHeightF            = 0.33                               ; view port height
 res@vpWidthF             = 0.66                               ; view port width
 res@vpXF                 = 0.22                               ; view port x offset
 res@trXMinF              = 0.00                               ; minimum x value
 res@trXMaxF              = 0.28                               ; maximum x value
 res@trYMinF              = 0.00                               ; minimum y value
 res@xyLineColors         = (/"red"/)                          ; color of plot line
 res@xyLineThicknesses    = (/4.0/)                            ; thickness of plot line
 res@tiYAxisString        = "PROGRAMMING~C~         SKILL"     ; y-axis label (center justified with spaces)
 res@tiXAxisString        = "BLOOD ALCOHOL CONCENTRATION (%)"  ; x-axis label
 res@tiMainString         = "Ballmer Peak"                     ; add title
 res@tiMainFontHeightF    = 0.022                              ; main font size
 res@tmYRBorderOn         = False                              ; turn off y-axis right border
 res@tmXTBorderOn         = False                              ; turn off x-axis top border
 res@tmYLOn               = False                              ; turn off left y-axis ticks
 res@tmYROn               = False                              ; turn off right y-axis ticks
 res@tmXTOn               = False                              ; turn off top x-axis ticks
 res@tmXBMode             = "Explicit"                         ; label x-axis with explicit values and labels (next 2 lines)
 res@tmXBValues           = (/.00,.02,.04,.06,.08,.10,.12,.14,.16,.18,.20,.22,.24,.26/)
 res@tmXBLabels           = (/".00",".02",".04",".06",".08",".10",".12",".14",".16",".18",".20",".22",".24",".26"/)
 res@tmXBLabelFontHeightF = 0.010                              ; x-axis tick mark font size
 res@tiXAxisFontHeightF   = 0.016                              ; x-axis font size
 res@tiYAxisFontHeightF   = 0.016                              ; y-axis font size
 res@tiYAxisAngleF        = 0.0                                ; rotate y-axis lable

 plot  = gsn_csm_xy (wks,x,y,res)                              ; create plot
end
