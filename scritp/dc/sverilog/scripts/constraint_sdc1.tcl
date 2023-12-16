#============================================================
#wite post_process files
#=============================================================
set compile_automatic_clock_phase_inference relaxed
set compile_seqmap_propagate_constants false

set compile_enable_constant_propagation_with_no_boundary_opt false
set timing_enable_multiple_clocks_per_reg true
set enable_recovery_removal_arcs true

#===========================================================
#Defined clock
#===========================================================
set CLK_NAME      clock
set CLK_PERIOD    [expr 1000/1]
#the clk frequence is 1MHZ
set CLK_SKEW      [expr $CLK_PERIOD * 0.05]
set CLK_TRAN      [expr $CLK_PERIOD * 0.01]
set CLK_SRC_LATENCY  [expr $CLK_PERIOD * 0.1]
set CLK_LATENCY   [expr $CLK_PERIOD * 0.1]
create_clock -name $CLK_NAME -period $CLK_PERIOD  [get_ports $CLK_NAME]
set_ideal_network      [get_ports $CLK_NAME]
set_dont_touch_network [get_ports $CLK_NAME]
set_drive  0           [get_ports $CLK_NAME]
set_clock_uncertainty     -setup $CLK_SKEW       [get_ports $CLK_NAME]
set_clock_transition      -max   $CLK_TRAN       [get_ports $CLK_NAME]
set_clock_latency -source -max $CLK_SRC_LATENCY  [get_ports $CLK_NAME]
set_clock_latency         -max $CLK_LATENCY      [get_ports $CLK_NAME]



#=============================================================
#Define reset
#=============================================================
set RST_NAME    resetN
set_ideal_network [get_ports $RST_NAME]
set_dont_touch_network [get_ports $RST_NAME]
set_drive  0           [get_ports $RST_NAME]




#=============================================================
#set input delay
#============================================================
set ALL_IN_EXCEPT_CLK [remove_from_collection [all_inputs]  [get_ports $CLK_NAME]]
set INPUT_DELAY       [expr $CLK_PERIOD * 0.1]
set_input_delay   -max  $INPUT_DELAY     -clock $CLK_NAME    $ALL_IN_EXCEPT_CLK  




#=============================================================
#set output delay
#=============================================================
#set   LIB_NAME          tcbn65gplustc
#set   OPERA_CONDITION   NCCOM
#set   OUTPUT_DELAY 0
set   OUTPUT_DELAY   [expr $CLK_PERIOD * 0.1]
set_output_delay   -max  $OUTPUT_DELAY   -clock $CLK_NAME [all_outputs]
set_output_delay   -min  [expr $OUTPUT_DELAY * 0.1]   -clock $CLK_NAME [all_outputs]
#set   MAX_LOAD       [expr [load_of $LIB_NAMEBUFFD3BWP7TZ]10]

set_load                  2             [all_outputs]
#2pf
#set_load             [expr $MAX_LOAD1]   [all_outputs]
#set_isolate_ports    -type buffer         [all_outputs]




#===========================================================
#set_operating_conditions & wire_load model
#==========================================================
#set_operating_conditions    -max $OPERA_CONDITION 
#                            -max_library $LIB_NAME
#set   auto_wire_load_selection  false
#set_wire_load_mode top
#use dc auto wire_load
set auto_wire_load_model ture





#============================================================
#DRC_RULES
#============================================================
set_max_area 0
#set_max_fanout        32  [get_designs $TOP_MODULE]
#set_max_transition  1000 [get_designs $TOP_MODULE]
#set_max_capacitance 500 [get_designs $TOP_MODULE]







#============================================================
#set group path 
#avoid getting stack on one path
#=============================================================
group_path  -name $CLK_NAME  -weight 5                            -critical_range [expr $CLK_PERIOD *  0.1]
group_path  -name INPUTS   -from [all_inputs]                     -critical_range [expr $CLK_PERIOD *  0.1]
group_path  -name OUTPUTS  -to [all_outputs]                      -critical_range [expr $CLK_PERIOD *  0.1]
group_path  -name COMP     -from [all_inputs]  -to [all_outputs]  -critical_range [expr $CLK_PERIOD *  0.1]
report_path_group
#==============================================================
