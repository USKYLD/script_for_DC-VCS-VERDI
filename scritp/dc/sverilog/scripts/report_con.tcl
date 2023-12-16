report_clock > $REPORT_PATH/clock.syn.rpt
report_clock -skew >> $REPORT_PATH/clock.syn.rpt

current_design $TOP_MODULE

uniquify -force
