check_design  > $REPORT_PATH/check_design.rpt
check_timing  > $REPORT_PATH/check_timing.rpt

report_qor > $REPORT_PATH/qor.rpt

report_area > $REPORT_PATH/area.rpt
report_area -hierarchy > $REPORT_PATH/area_hier.rpt
report_timing   -loops > $REPORT_PATH/timing_loop.rpt
report_timing -path full -net -cap -input -tran -delay min -max_paths 200 -nworst 200 > $REPORT_PATH/timing.min.rpt
report_timing -path full -net -cap -input -tran -delay max -max_paths 200 -nworst 200 > $REPORT_PATH/timing.max.rpt
report_constraints -all_violators -verbose > $REPORT_PATH/constraints.rpt
report_power > $REPORT_PATH/power.rpt
report_ideal_network > $REPORT_PATH/IdealNetwork.rpt

