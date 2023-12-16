##################################################################
## Optimization
##################################################################
change_names -rules verilog -hierarchy

#   there is no supprot of compile_ultra,so use compile
compile_ultra -gate_clock -no_seq_output_inversion -no_autoungroup -timing_high_effort_script > $REPORT_PATH/compile.rpt

#do_compile > $RPT_OUT/compile.rpt
#do_compile_inc > $RPT_OUT/compile_inc.rpt
#do_compile_inc > $RPT_OUT/compile_inc.rpt
#
change_names -rules verilog -hierarchy
current_design $TOP_MODULE
