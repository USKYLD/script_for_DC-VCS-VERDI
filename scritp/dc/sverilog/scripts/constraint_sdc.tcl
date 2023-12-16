#============================================================
#wite post_process files
#=============================================================
set compile_automatic_clock_phase_inference relaxed
set compile_seqmap_propagate_constants false

set compile_enable_constant_propagation_with_no_boundary_opt false
set timing_enable_multiple_clocks_per_reg true
set enable_recovery_removal_arcs true

#===========================================================
#-----------------------------------------------------------------------------
# Clock definitions

set pre_clock_margin 0.8
set_max_fanout 32 [current_design]
#set_max_transition 0.3 [current_design]

# The r_clk period is user-defined.
set PERIOD 1000.0


create_clock -name r_clk -period [expr $PERIOD*$pre_clock_margin] [get_ports r_clk]
create_clock -name w_clk -period [expr $PERIOD*$pre_clock_margin] [get_ports w_clk]

set_clock_groups -asynchronous -group [get_clocks r_clk] 
set_clock_groups -asynchronous -group [get_clocks w_clk]

# Set the clock transition time to a value compatible with its period.
set CTRANSITION 40.0
set_clock_transition  $CTRANSITION  r_clk
set_input_transition  $CTRANSITION  [get_ports r_clk]

set_clock_transition  $CTRANSITION  w_clk
set_input_transition  $CTRANSITION  [get_ports w_clk]

# Set the clock uncertainty to a value compatible with its period.
set UNCERTAINTY 50.0
set_clock_uncertainty -setup $UNCERTAINTY [get_clocks r_clk]
set_clock_uncertainty -setup $UNCERTAINTY [get_clocks w_clk]

set CLOCKS_LIST [ list \
    w_clk \
    r_clk \
    ]

set_dont_touch_network  [all_clocks]
set_ideal_network       [all_clocks]

set RESETS_LIST [ list \
    w_rst_n \
    r_rst_n \
    ]

if { [llength RESETS_LIST ] > 0 } {
    foreach RstName $RESETS_LIST {
        echo "INFO: Defining Reset : $RstName"
        set_drive 0 [get_ports $RstName -filter {@port_direction ==in} -quiet]
        set_false_path -from [get_ports $RstName -quiet]
        set_ideal_network -no_propagate [get_nets -of_object [get_ports $RstName -filter {@port_direction == in} -quiet] -quiet]
    }
}


#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Input assertions

# Set the data transition time to a value compatible with the Pclk period.
set DTRANSITION 0.5

# Set the input max cap load to a value compatible with the target library.
set ILOAD 50.0

# Input delay times:
#   PI10 = Input is valid at 10% of cycle
#   PI25 = Input is valid at 25% of cycle
#   PI50 = Input is valid at 50% of cycle
#   PI75 = Input is valid at 75% of cycle
#   PI90 = Input is valid at 90% of cycle

#   Begin   = PI10
#   Early   = PI25
#   Middle  = PI50
#   Late    = PI75
#   End     = PI90

set PI10 [expr $PERIOD * 0.10]
set PI25 [expr $PERIOD * 0.25]
set PI50 [expr $PERIOD * 0.50]
set PI75 [expr $PERIOD * 0.75]
set PI90 [expr $PERIOD * 0.90]

set_input_transition  $DTRANSITION                    [all_inputs]
set_max_capacitance   $ILOAD                          [all_inputs]

#-----------------------------------------------------------------------------
# Output assertions

# Set the output cap load to a value compatible with the target library.
set OLOAD 1

# Output delay times:
#   PO10 = Output is valid at 10% of cycle
#   PO25 = Output is valid at 25% of cycle
#   PO50 = Output is valid at 50% of cycle
#   PO75 = Output is valid at 75% of cycle
#   PO90 = Output is valid at 90% of cycle

#   Begin   = PO10
#   Early   = PO25
#   Middle  = PO50
#   Late    = PO75
#   End     = PO90

set PO10 [expr $PERIOD * ( 1.0 - 0.10 ) - $UNCERTAINTY]
set PO25 [expr $PERIOD * ( 1.0 - 0.25 ) - $UNCERTAINTY]
set PO50 [expr $PERIOD * ( 1.0 - 0.50 ) - $UNCERTAINTY]
set PO75 [expr $PERIOD * ( 1.0 - 0.75 ) - $UNCERTAINTY]
set PO90 [expr $PERIOD * ( 1.0 - 0.90 ) - $UNCERTAINTY]

set_load $OLOAD [all_outputs]

#--------------------------------------------------------------------------
# input assertions
#--------------------------------------------------------------------------
#
set_input_delay $PI10 -clock r_clk [get_ports r_en]
set_input_delay $PI10 -clock w_clk [get_ports w_en]
set_input_delay $PI10 -clock w_clk [get_ports w_data]

#--------------------------------------------------------------------------
# Output assertions
#--------------------------------------------------------------------------
set_output_delay $PO90 -clock r_clk [get_ports r_empty]
set_output_delay $PO90 -clock r_clk [get_ports r_data]
set_output_delay $PO90 -clock w_clk [get_ports w_full]

set AllInputNoClkRst [remove_from_collection [all_inputs] [list $RESETS_LIST $CLOCKS_LIST] ]
set AllOutput   [all_outputs]

set_max_delay [ expr $PERIOD*$pre_clock_margin ] -from $AllInputNoClkRst -to $AllOutput
#set_wire_load_mode {top/enclosed/segmented}
set_wire_load_mode  top
#set_wire_load_model -name MEDIUM

#Group

set clock_ports [get_ports -quiet [all_fanout -clock_tree -flat]]
set all_inputs [all_inputs]
set all_outputs [all_outputs]
set all_nonclk_inputs [remove_from_collection $all_inputs $clock_ports]
set all_nonclk_outputs [remove_from_collection $all_outputs $clock_ports]
set all_icgs [get_cells -hier -filter "is_integrated_clock_gating_cell == true"]
set all_reg [all_registers]
set all_reg [remove_from_collection $all_reg $all_icgs]
set all_mem [get_cells -hierarchical -filter "is_memory_cell == true"]

group_path -from $all_reg -to $all_reg -name reg2reg
group_path -from $all_reg -to $all_nonclk_outputs -name reg2out
group_path -from $all_nonclk_inputs -to $all_reg -name in2reg 
group_path -from $all_nonclk_inputs -to $all_nonclk_outputs -name in2out 
#group_path -from $all_mem -to $all_reg -name mem2reg
#group_path -from $all_reg -to $all_mem -name reg2mem 

#-----------------------------------------------------------------------------

echo "$TOP_MODULE has [sizeof_coll [all_reg]] registers"
set design_all_clocks [all_clocks]
foreach_in_collection clk $design_all_clocks {
    set no_clock_reg [remove_from_collection [all_registers] [all_registers -clock $clk]]
}
query_objects $no_clock_reg  > $REPORT_PATH/registers_witout_clk.$TOP_MODULE.rpt
