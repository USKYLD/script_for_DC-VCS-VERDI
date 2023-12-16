.PHONY:vcs sim check cov wave clean verdi change

#all path
vpath %.v ../rtl     
LOG_PATH:= ./log
#RTL_PATH:= ../rtl

#all name
OUTPUT:=async_fifo
VPD_NAME:=${OUTPUT}.vpd
FSDB_NAME:=${OUTPUT}.fsdb
VERILOG_NAME:=async_fifo.v async_fifo_tb.v

#gate verilog simulation
LIB_EXT:=+libext+.v
LIB_FILE:=/root/library/tsmc18/Std_lib/fb_tsmc-cl018g_sc-x_2004q3v1/aci/sc/verilog/tsmc18.v

#define and timescale
ALL_DEFINE:=+define+FSDB +define+VPD                                 #+define+VCD
TIMESCALE:=1ns/1ps

#code coverage command
CM:= -cm line+cond+fsm+branch+tgl
CM_NAME:= -cm_name ${OUTPUT}
CM_DIR:= -cm_dir ./${OUTPUT}.vdb

#COMPILE command elaboration
VCS:=	vcs  -full64 +v2k -R -debug_acc+dmptf -debug_region+cell+encrypt		    \
	-sverilog 						      			    \
	-P /usr/synopsys/vc_static-O-2018.09-SP2-2/verdi/share/PLI/VCS/LINUXAMD64/novas.tab \
	/usr/synopsys/vc_static-O-2018.09-SP2-2/verdi/share/PLI/VCS/LINUXAMD64/pli.a        \
	-timescale=${TIMESCALE}					      			    \
	+vcs+flush+all						      			    \
	-y ${LIB_DIR}							      		    \
	-v ${LIB_FILE}							      		    \
	${LIB_EXT}							      		    \
	${CM}							      			    \
	${CM_NAME}						      			    \
	${CM_DIR}						      			    \
	${ALL_DEFINE}						      		  	    \
	+vpdfile+${VPD_NAME}						      	            \
	-o ${OUTPUT}						      			    \
	-l ${LOG_PATH}/${OUTPUT}.log						            \
	+rad  -Mupdate +no_notifier +sdfverbose +neg_tchk -negdelay
#+vcs+initreg +random

#SIM command	simulation		      
SIM:=./${OUTPUT}                   				      			    \
	-gui                        				      			    \
	-l ${LOG_PATH}/run.log        				      			    \
	${CM}			             			      			    \
	${CM_NAME}		               			      			    \
	-cm_nocasedef									    \
	${CM_DIR}

#check command analysis
VLOGAN:=vlogan -full64    -sverilog         				      		    \
	-l ${LOG_PATH}/check.log

#mid file		
MID_FILE:=csrc DVEfiles .vlogansetup.args *.daidir  *.key  *.DB

#vcs
vcs:log ${VERILOG_NAME}
	${VCS} $^

sim:vcs
	${SIM} &

check:log ${VERILOG_NAME}              
	${VLOGAN} $^

log:
	mkdir log

cov:
	dve -full64 -covdir *.vdb &

wave:
	dve -vpd ${VPD_NAME} &

verdi: ${VERILOG_NAME}
	verdi $^ -ssf ${OUTPUT}.fsdb

clean:
	rm -r ${MID_FILE} ${OUTPUT} *log *.vdb *.vpd verdi* novas* *.fsdb .* urg*
change:
	urg -dir *.vdb
#user instructions:
#The width of Tab is 8;
#Please add the code in wave.v to your testbench;
#Please place your rtl code in ../rtl;
#pleace palce this makefile to ../simulation;
#Two ways to use this makefile;
#The first:make check ;make (vcs);make wave;make cov;make change;make verdi;make clean;
#The second:make check;make sim;make clean;






		
