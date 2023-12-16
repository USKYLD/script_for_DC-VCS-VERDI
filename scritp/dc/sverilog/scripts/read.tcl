#===========read and elaborate the rtl file list and check=======
set TOP_MODULE traffic_light
echo "******set the top module*******"
#please set the top module
echo "************analyze************"
lappend DEFINE_LIST ""
analyze -format sverilog  -define $DEFINE_LIST -vcs "-f $RTL_PATH/flist.f" 
#the first one is the TOP_MODULE
#analyze -format verilog [list SAR_ADC_12.v]
echo "************elaborate************"
elaborate $TOP_MODULE 
#you can add command -parameters "ADC_WIDTH = 9"

echo "***************report_attributes***********"
report_attributes -design
#report_attributes -pin

current_design $TOP_MODULE

echo "************link************"
link

uniquify -force -dont_skip_empty_designs


#makesure the link and check 
if {[link]==0} {
    echo "link with error!"
    exit
}
if {[check_design]==0} {
    echo "check_design with error"
    exit
}

#=================reset the design first===================
reset_design

#=================write the unmapped ddc file===================
uniquify -force
set uniquify_naming_style "%s_%d"
write -f ddc -hierarchy -output ${UNMAPPED_PATH}/${TOP_MODULE}.ddc

