###################################################################
## Saving Hierarchy
###################################################################
set bus_naming_style {%s[%d]} 
write_file -f verilog -hierarchy -output $MAPPED_PATH/$TOP_MODULE.v
write_sdf -version 2.1 $MAPPED_PATH/$TOP_MODULE.sdf
write_file -f ddc -hierarchy -output $MAPPED_PATH/$TOP_MODULE.ddc

write_sdc $MAPPED_PATH/$TOP_MODULE.sdc
