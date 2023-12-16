echo "***********************************"
echo "read verilog and report ddc"
source  $SCRIPT_PATH/read.tcl
echo "***********************************"
echo "set_parameter"
source  $SCRIPT_PATH/set_parameter.tcl
echo "***********************************"
echo "set constraints"
source  $SCRIPT_PATH/constraint_sdc1.tcl
echo "***********************************"
echo "set do_not_touch"
source  $SCRIPT_PATH/dont_touch.tcl
echo "***********************************"
echo "report constrains"
source  $SCRIPT_PATH/report_con.tcl
echo "***********************************"
echo "optimization"
source  $SCRIPT_PATH/optimization.tcl
echo "***********************************"
echo "check and report"
source  $SCRIPT_PATH/report_result.tcl
echo "***********************************"
echo "save"
source  $SCRIPT_PATH/save.tcl
echo "***********************************"
echo "end of design compile"
echo "author szr"
