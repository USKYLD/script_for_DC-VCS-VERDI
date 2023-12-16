#---------------------------------------------------------------------------------------------------------------------------
# SYNOPSYS CONFIDENTIAL - This is an unpublished, proprietary work of 
# Synopsys, Inc., and is fully protected under copyright and trade secret 
# laws. You may not view, use, disclose, copy, or distribute this file or 
# any information contained herein except pursuant to a valid written 
# license from Synopsys. 
# SYNOPSYS公司的版权声明，没有权限不可使用 
#-----------------------------------------------------------------------------------------------------------------------------
#  Filename : $Id: Makefile,v 1.0 2006/07/18 23:59:59 vangundy Exp $ 
#  Created by   : Synopsys Inc. 07/17/2006 
#  $Author     : vangundy $ 
#  Description : Demonstrates Verilog DUT and SVTB using VCS

 

#  makefile文件头

#---------------------------------------------------------------------------------------------------------------------------
#   The Makefile works on two seperate flows.  The DEBUG flow is intended to be used 
#   During debugging of a testcase and/or the DUT.   The REGRESSION flow is used 
#   During regression runs and collects coverage data. 
#  该makefile模版包括两部分流程，debug（查错）流程和regress（回归测试）流程，两个流程大致步骤都相同都是：Compile，SIM（urg，覆盖 
#  率的分析和采集），debug时主要是跑一个pattern，并dump VPD文件，SIM的同时可以打开DVE视图界面，结束后观察波形，regress主要用
#  于采集覆盖率，一般要跑多个pattern，这时就无需dump VPD文件（节约时间），由于是debug后有进行的重复运行，所以叫regress（回归）。 
#  在我们的验证平台中，若不做代码覆盖率的功能，可以不写regress，只要写debug的流程和跑多个pattern的脚本就好了。 
#---------------------------------------------------------------------------------------------------------------------
#   The DEBUG flow turns on VPD dumping and turns off coverage collection.   After 
#   building a testcase using the debug targets, you can debug the TB and the DUT   
#   source code using the testbench debugger and DVE.   Of course, you can turn on 
#   coverage metrics and run in debug mode by changing compile and runtime options 
#   in the makefile.  These changes are independent of the regression flow so that      
#   the regressions will still run optimally without the interference of VPD dumping. 

#   debug流程打开VPD文件的dump并关闭覆盖率在build了一个包含DUT的testcase后，可以使用VCS的debugger和DVE进行debug。当 
#   然，你也以通过改变makefile文件中的compile和runtime选项参数来开启覆盖率功能。Debug流程和regress流程是各自独立的，regression 
#   流程一般不生成VPD。 
# --------------------------------------------------------------------------------------------------------------------------------
#   The REGRESSION flow turns off VPD dumping and turns on Coverage Metrics and TB 
#   coverage collection.   This flow is intended to support verification engineers who 
#   are working through the regression process and are interested in coverage 
#   collection and urg. 
#   REGRESSION流程关闭VPD dump并打开Coverage collection功能，该流程是为了支持验证引擎进行“流水线验证“（跑多个testcase）和 
#   代码覆盖率功能。？？在验证平台中可以将运行多个testcase的脚本命名为regress，运行单个testcase的脚本命名为regone？？，这只是

#  synopsys的模版，我们不必完全遵守，可以不区分debug和regress，然后将是否打开波形和coverage设置成参数。

# -------------------------------------------------------------------------------------------------------------------------------
#   Command Line   make命令行 
#   ----------------- 
#   The Makefile supports the following command line 
#   makefile支持下列命令行 
#  % make target_name_* <SEED=xxx> <DEFINES=xxxx>
#   makefile文件放在哪？放在仿真路径。make [-f makefile文件名][选项][宏定义][目标]  
#   -f 指定makefile  若没有则make程序首先在当前目录查找名为makefile的文件，如果没有找到，它就会转而查找名为Makefile的文件。 
#   Where target_name is the name of a testcase located in the test directory.   Every 
#   test in the test directory is named using test_{test_name}.   All of the test targets 
#   are listed in the TEST TARGETS section of the makefile.

 

#  target_name是test路径下的一个testcase的名字，test路径下的testcase的名字使用test_{test_name}来命名，例如test_1

 

#  所有的test target 都在makefile文件中的TEST TARGETS部分列出 
# ---------------------------------------------------------------------------------------------------------------------------
#   Compile and Run Testcases     编译与运行testcase 
#   ------------------------------- 
#   To compile and run a tescase use the test_* and regress_test_* targets. 
#   编译与运行testcase，（test_1 就是执行了下面的两个命令先编译在运行） test_1 ==> compile_1  run_1   详见下面命令定义 
#   % make test_1           # Builds and runs test 1 with VPD dumping        其实就是debug的前边的流程 
#   % make regress_test_1 # Builds and runs test 1 with coverage turned on  
#  -------------------------------------------------------------------------------------------------------------------------
#   Debugging Testcases     Debug 实在上面命令之后在进行的 
#   ------------------------ 
#   You can use DVE and the testbench debugger to visualize waveforms and testbench 
#   execution.   You must first build the testbench using the make compile_* command. 
#   dubug必须是在DVE（VCS的debug工具，与debussy一样的功能）下进行，因为要看波形嘛，但是debug之前必须先compile 
#  % make compile_1        # Builds test 1 for debugging    #需要重新编译一次吗？ 
#   Once you have built the environment with the proper debug switches, you can use DVE and the testbench debugger. 
#  #   testbench debugger 是否是指编译后的那个simv可执行文件呢？  其实gui_1 和上面test_1中的run_1是一样的只是增加了-gui项 
#   即增加了打开gui界面的参数，其他雷同

#  % make gui_1           # Debug test 1 with DVE 
#   % make tb_gui_1       # Debug test 1 with the testbench debugger 
#  % make both_guis_1  # Debug using both guis 
#   % make pp_1           # Debug using the VPD file   VPD文件要在执行simv之后才有吧？ 
#   If you want, you can turn on coverage for the DEBUG flow by uncommenting the 
#   coverage flag in the makefile.   If you do this, you can still look at coverage. 
#   This may be useful in helping those who are debugging coverage related issues. 
#   如果在makefile中的debug流程中使用了coverage功能，那么可以使用下面命令观察覆盖率 
#   % make urg              # Visualize coverage data from debug runs 
#  -----------------------------------------------------------------------------------------------------------------------------
#   Regression Testcases 
#   -------------------- 
#   Regression tests are used to collect coverage information.   To build a testcase 
#   for coverage collection use a command similar to the following. 
#   regress流程主要是为了收集代码覆盖率信息，在执行regress之前需要重新build testcase  类似debug时的compile 
#   % make regress_build_1   # Build and run a regression test with a default seed 
#   Once the test has been built, you can run it again with a new seed. 
#   与debug不同的是regress需要重新run（使用新的SEED）一下，【还是debug的时候也要run一下？】 
#  % make regress_run_1 SEED=1234 
#   After running one or more regression runs, you can visualize the coverage data 
#   using urg and the following command 
#  run完之后可以用下面命令看代码覆盖率 
#   % make regress_urg 
#----------------------------------------------------------------------------------------------------------------------------
# HOW TO REUSE THIS FILE ON ANOTHER DUT    #如何重用该模版 
# STEP 1:   Update the file locations as required   #设置file所属的路径 
# STEP 2:   Update the DUT section with directory and source location info#更新模版中DUT部分，指定DUT的路径和include的路径 
# STEP 3:   Update the TB section with directory and source location info#更新模版中TB部分，指定TB的路径和include的路径 
# STEP 4:   Update the Coverage section with name of dut top (eg top.dut) #跟新模版中Coverage部分，指定要测试代码覆盖率的dut的top 
# STEP 5:   Add test targets to the debug and regression targets section#将debug和regress的target加入模版中对应的部分 
# STEP 5:   Adjust the debug and regression compile and run time arguments#调整debug和regress的compile和runtime的命令参数 
# STEP 7:   Adjust command line options as required#调整命令行命令（后边带百分号和冒号的就表示可以在make命令行中使用的命令） 
# STEP 8:   Update the env class so that it extends dkm_env#更新env class（环境类）使得它可以提供dkm_env 
#    You will need to have a copy of the dkm directory and it should  #dkm是什么？ 
#       be located at $(TB_SRC_DIR)/dkm 
#       a) Add [`include "dkm_env.sv"] 
#       b) Add [extends dkm_env] to the environment class definition 
#       c) Call the super.new("name") from the constructor 
# STEP 9:   Run the debug and regression targets 
#      % make testbench_target_*   # testbench_target_*    是指test_1之类的testcase 
#-----------------------------------------------------------------------------

 

#看了上文，大家应该可以简单了解这个Makefile的功能了。接下来就按照step1~9来填空即可： 

.PHONY : default help clean regress_clean 
default: help 
#----------------------------------------------------------------------------- 
# DIRECTORIES    总路径 
#----------------------------------------------------------------------------- 
OUTPUT_DIR    = ./output      #为什么debug和regress没有分开？   debug和regress的Coverage在COV_DIR下是有区分的 
COV_DIR        = ./coverage    #为什么没有VPD的路径？   
LOG_DIR        = ./logs         #output是做什么的？   VPD文件  simv文件 还有一写其他文件在这里


# Set this to the location where you installed the designware models.   This 
# depends on whether you ran the setup_vip_dw_home to install the models or 
# the setup_vip_here script. 
#DW_MODELS_DIR = $(DESIGNWARE_HOME) 
DW_MODELS_DIR = /user/synopsys/designware      #软件路径  VCS的路径？ 
#DESIGNWARE_HOME = ~synopsys/bk/designware    
#DW_MODELS_DIR = ./designware 
#---------------------------------------------------------------------------- 
# DEVICE UNDER TEST     DUT路径 
#----------------------------------------------------------------------------- 
DUT_SRC_DIR   =  ./source/Verilog                #SRC  source 

DUT_SRC         = -f $(DUT_SRC_DIR)/rtl_list.f      #待编译的rtl文件列表文件  SRC是什么意思？ 
DUT_INC        += +incdir+/user/myproj/PROJECT/RTL/SRC/mymodule/ 
DUT_INC        += +incdir+/user/myproj/PROJECT/RTL/SRC/mymodule/mymodule_inc.v 

DUT_CMP_OPTIONS   += +libext+.v+.V            #这个参数是干什么的？指定VCS搜索文件时的文件后缀.v 
#DUT_CMP_OPTIONS   += -timescale=1ps/1ps     #CMP是compile的意思  不是compare 
#DUT_CMP_OPTIONS   += -override_timescale=1ps/1ps 
#----------------------------------------------------------------------------- 
# TESTBENCH      TB路径设置 
#----------------------------------------------------------------------------- 
TB_SRC_DIR    = ./source/svtb 

# AXI TESTBENCH, VIP Sources first 
#TB_SRC      += -f $(TB_SRC_DIR)/mac_if_tb/vip/gslv_model_package.f 
TB_SRC       += $(TB_SRC_DIR)/mpdu_trx_tb/tests/mpdu_tb_top.sv 
TB_SRC       += $(TB_SRC_DIR)/mpdu_trx_tb/tests/$(TB_TEST).sv   #为什么有两个SV 

TB_INC       += +incdir+$(TB_SRC_DIR)/mpdu_trx_tb/vip 
TB_INC       += +incdir+$(TB_SRC_DIR)/mpdu_trx_tb/env 
TB_INC       += +incdir+$(TB_SRC_DIR)/mpdu_trx_tb/tests 
TB_INC        += +incdir+$(DW_MODELS_DIR)/include/svtb      #这部分为了支持sv吗？ 
TB_INC        += +incdir+$(DW_MODELS_DIR)/include/verilog 
TB_INC        += +incdir+$(DW_MODELS_DIR)/svtb 

#TB_CMP_OPTIONS += -tb_timescale=1ns/1ps 
#TB_CMP_OPTIONS += -lca Y-2006.06-SP2 
TB_CMP_OPTIONS += +pkgdir+$(DW_MODELS_DIR)/include/svtb   #TB的编译选项和DUT不同？sv 和verilog的区别吗？ 
TB_CMP_OPTIONS += -ntb_incdir $(DW_MODELS_DIR)/include/vera 
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/vmt/latest/vera/src 
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/vera/src 
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_master_vmt/vera/src  #TB中使用的一些模型 
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_master_rvm_vera_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_slave_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_slave_rvm_vera_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_monitor_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_monitor_rvm_vera_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_port_monitor_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_port_monitor_rvm_vera_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_interconnect_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir $(DESIGNWARE_HOME)/vip/amba/latest/axi_interconnect_rvm_vera_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_master_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_slave_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_monitor_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_bus_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_master_rvm_vera_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_slave_rvm_vera_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_monitor_rvm_vera_vmt/vera/src 
TB_CMP_OPTIONS += -ntb_incdir ${DESIGNWARE_HOME}/vip/amba/latest/ahb_bus_rvm_vera_vmt/vera/src 

TB_CMP_OPTIONS += -ntb_define NTB 
TB_CMP_OPTIONS += -ntb_define DW_VIP_AXI_MAX_NO_MSTRS=6 
TB_CMP_OPTIONS += -ntb_define DW_VIP_AXI_MAX_NO_SLVS=2 
TB_CMP_OPTIONS += +define+DW_VIP_AXI_MAX_NO_MSTRS_6 
TB_CMP_OPTIONS += +define+DW_VIP_AXI_MAX_NO_SLVS_2 
TB_CMP_OPTIONS += -ntb_opts rvm 
TB_CMP_OPTIONS += -ntb_opts dtm 
TB_CMP_OPTIONS += -ntb_opts use_sigprop 
TB_CMP_OPTIONS += -ntb_opts interop 
TB_CMP_OPTIONS += -ntb_opts dw_vip 
TB_CMP_OPTIONS += +define+NT 

# AIP Related files and compilation options 
#TB_CMP_OPTIONS += +incdir+../BP062-BU-01000-r0p0-00rel0/sva \ 
               +incdir+../BP062-BU-01000-r0p0-00rel0/verilog \ 
               ../BP062-BU-01000-r0p0-00rel0/sva/AxiPC.sv \ 
               ../BP062-BU-01000-r0p0-00rel0/verilog/Axi.v \ 
               ./source/svtb/platform_tb/env/Snps_ARMAXI_CheckerBind.sv 

#${VCS_HOME}/packages/aip/DDR2_AIP/src/Snps_DDR2_Checker.sv \ 
               -assert enable_diag \ 
               +incdir+.+${VCS_HOME}/packages/aip/DDR2_AIP/src/ \ 
               ./source/svtb/platform_tb/env/Snps_DDR2_Bind.sv \ 
   +incdir+../BP062-BU-01000-r0p0-00rel0/sva \ 
               +incdir+../BP062-BU-01000-r0p0-00rel0/verilog \ 
               ../BP062-BU-01000-r0p0-00rel0/sva/AxiPC.sv \ 
               ../BP062-BU-01000-r0p0-00rel0/verilog/Axi.v \ 
               ./source/svtb/platform_tb/env/Snps_ARMAXI_CheckerBind.sv 
#----------------------------------------------------------------------------- 
# COVERAGE 覆盖率的设置 
#----------------------------------------------------------------------------- 
COV_TREE        += '+tree mpdu_tb_top' 
COV_CM_OPTIONS   += -cm line+cond+fsm+assert    注意CM和CMP不一样 
#----------------------------------------------------------------------------- 
# TEST TARGETS   总命令 
#----------------------------------------------------------------------------- 
# debug targets 
test_1: compile_1 run_1     与前边对应test_1 就是debug流程（debug还可以将run_1 换成 gui_1）；regress_test_1就是regress流程 
test_11: compile_11 run_11 
test_12: compile_12 run_12 
test_13: compile_13 run_13 
test_14: compile_14 run_14 
test_2: compile_2 run_2 
test_perf: compile_perf run_perf 

# regression targets 
regress_test_1: regress_build_1 regress_run_1 
regress_test_11: regress_build_11 regress_run_11 
regress_test_12: regress_build_12 regress_run_12 
regress_test_13: regress_build_13 regress_run_13 
regress_test_14: regress_build_14 regress_run_14 
regress_test_2: regress_build_2 regress_run_2 
regress_test_perf: regress_build_perf regress_run_perf 
#----------------------------------------------------------------------------- 
# COMPILE AND RUN TIME ARGUMENTS  编译与运行时的参数设置（run和sim可以看成一个意思，run就是run simv） 
#----------------------------------------------------------------------------- 
# Debug compile time arguments 
DBG_CMP           += $(COV_CMP_OPTIONS) #debug 编译的参数 
DBG_CMP           += -debug_all                    #使能DVE debugging （包括 line stepping） 
#DBG_CMP           += -debug_pp                             #使能VPD dump 和assertion debug 
DBG_CMP           += +define+VPD_ON           #debug compile的时候定义一个VPD_ON的宏，注意VPD是SIM时生成的 
#DBG_CMP           += +define+VPD_OFF          #若CMP时参数把VPD关了,但是在SIM时输出一个VPD会怎么样？ 
#DBG_CMP           += +define+LOG_FMT_OFF     #应该是这样，在verilog代码中将VPD dump的代码写在 ifdefine VPD_ON 后面 
# Debug run time arguments 
DBG_RUN           += $(COV_SIM_OPTIONS)      #COV_SIM_OPTION 和 COV_CMP_OPTION的区别 

# Regression compile time arguments 
REG_CMP           += $(COV_CMP_OPTIONS) 
REG_CMP           += +define+VPD_OFF         #regress compile的时候定义了VPD_OFF， debug和regress的区别其实主要就是这， 
                                                #因为debug时也可以做urg，所以在CMP和SIM参数中关于覆盖率实际上是一致的 
# Regression run time arguments                #注意在debug和regress各自的流程中urg命令（make 命令行命令）是不同的 
REG_RUN           += $(COV_SIM_OPTIONS)         

# Define where the coverage data is for URG        #覆盖率数据,这个是给后边urg命令用的，产生覆盖率实在CMP和SIM之后进行的 
COV_DBG_DATA     += -dir $(COV_DIR)/debug/simv.vdb -dir   $(COV_DIR)/debug/simv.cm 
COV_REG_DATA     += -dir $(COV_DIR)/regress/simv.vdb -dir   $(COV_DIR)/debug/simv.cm 
#----------------------------------------------------------------------------- 
# COMMAND LINE ARGUMENTS  make命令行参数 
#----------------------------------------------------------------------------- 
SEED       = 766 
#234567 
#DEFINES    = "+rvm_log_default=DEBUG" 
DEFINES    = "+vmm_log_default=DEBUG" 
#DEFINES    = "+vmm_log_default=NOTE" 
#DEFINES    = "+rvm_log_default=WARNING" 
#DEFINES    = "+vmm_log_default=ERROR"

 


##############################################################################

 

############################################################################## 
# PRIVATE    #私有部分,用户可以不改 
# You should not need to modify anything below this point 
# The following code supports a SV DUT and SVTB.  

 

############################################################################## 
############################################################################## 
DIR          = $(/user/synopsys/Gaon/Platform) 
########################################################################## 
# DEVICE UNDER TEST  DUT CMP和SIM参数设置，之前已经设置过debug和regress在Compile时的参数 
########################################################################## 
DUT_CMP_OPTIONS   += -sverilog +v2k 
DUT_CMP_OPTIONS   += -o $(DUT_SIM_EXEC) 
DUT_CMP_OPTIONS   += -Mdir=$(OUTPUT_DIR)/$(TB_TEST_ID)_csrc 
DUT_CMP_OPTIONS   += -l $(LOG_DIR)/$(TB_TEST).cmp_log 
DUT_CMP_OPTIONS   += +vcs+lic+wait +plusarg_save 
DUT_CMP_OPTIONS   += $(DUT_INC) 

DUT_SIM_OPTIONS   += -l $(LOG_DIR)/$(TB_TEST_ID).run_log 
DUT_SIM_OPTIONS   += +vcs+lic+wait 
DUT_SIM_OPTIONS   += +vpdfile+$(OUTPUT_DIR)/$(TB_TEST_ID).vpd   

 

#vpd实在执行sim后生成的，但是在debugcompile的时候为什么有个vdp_on的参数呢? 
#DUT_SIM_OPTIONS   += +ntb_random_seed=$(SEED) 
DUT_SIM_OPTIONS   += +ntb_random_seed_automatic 
DUT_SIM_OPTIONS   += -assert nopostproc+report=$(LOG_DIR)/$(TB_TEST_ID).sva_log 
DUT_SIM_OPTIONS   += -cm_assert_name $(TB_TEST_ID) 
DUT_SIM_OPTIONS   += $(DEFINES) 
DUT_SIM_EXEC     += $(OUTPUT_DIR)/$(TB_TEST)_simv 

########################################################################## 
# TESTBENCH   TB CMP和SIM参数设置，之前已经设置过debug和regress在Compile时的参数 
########################################################################## 
TB_TEST        += test_$*               #$*是什么意思,$* ：去掉后缀的当前目标名(?)。例如，若当前目标是pro.o，则$*表示pro。 
TB_TEST_ID    += $(TB_TEST)_$(SEED) 
# VK ENVIRONMENT 
TB_INC           += +incdir+$(TB_SRC_DIR)/vk 
TB_CMP_OPTIONS +=   $(TB_INC) 
########################################################################## 
# COVERAGE  覆盖率设置 
########################################################################## 
#COV_CM_OPTIONS += +tb_cov_db_name=$(TB_TEST_ID) 
COV_CM_OPTIONS  += -cm_name $(TB_TEST_ID) 

COV_CMP_OPTIONS   += $(COV_CM_OPTIONS) -cm_hier $(COV_HIER) 

COV_SIM_OPTIONS   += $(COV_CM_OPTIONS) 
COV_SIM_OPTIONS   += -cm_log $(LOG_DIR)/$(TB_TEST_ID).cm_log 

COV_HIER       += $(OUTPUT_DIR)/vcm.cfg 

# Coverage options for build and run with debug    
COV_CM_DBG     += -cm_dir $(COV_DIR)/debug/simv.cm 
#COV_CM_DBG     += -ova_dir $(COV_DIR)/debug/simv.vdb 
#COV_CM_DBG     += +tb_cov_db_dir=$(COV_DIR)/debug/simv.vdb 

# Coverage options for build and run with regressions 
COV_CM_REG     += -cm_dir $(COV_DIR)/regress/simv.cm 
COV_CM_REG     += -ova_dir $(COV_DIR)/regress/simv.vdb 
COV_CM_REG     += +tb_cov_db_dir=$(COV_DIR)/regress/simv.vdb 
########################################################################## 
# DEBUG TARGETS 
########################################################################## 
compile_%: 
echo $(COV_TREE) > $(COV_HIER);   #debug 编译时主要有下面几个参数  TB_CMP  DUT_CMP  DBG_CMP COV_CM_DBG 
vcs $(TB_CMP_OPTIONS) \                   #请详细查看上面几个变量的设置 
         $(DUT_CMP_OPTIONS) \ 
      $(DUT_SRC) \ 
      $(TB_SRC) \ 
      $(SVA_SRC) \ 
      $(SVA_OPTIONS) \ 
      $(COV_CM_DBG) \ 
      $(DBG_CMP)                   
run_%:   

 

$(DUT_SIM_EXEC) $(DUT_SIM_OPTIONS) $(DBG_RUN) $(COV_CM_DBG)

 

#run 是上面说的test_1中的第二步，属于debug流程，其实就是执行simv，参数有DUT_SIM和DBG_RUN

 

#注意TB在run（sim）时没有相关参数 

gui_%:      #gui_1和run_1的区别就是打开了视图界面，他们都是执行sim 
$(DUT_SIM_EXEC) $(DUT_SIM_OPTIONS) $(DBG_RUN) $(COV_CM_DBG) \ 
-gui 

tb_gui_%:  #-tb_gui 和-gui的区别是什么（上文提到DVE和testbenchdebugeer的含义），猜测-gui是打开DVE软件，-tb_gui就不知道是神马 
$(DUT_SIM_EXEC) $(DUT_SIM_OPTIONS) $(DBG_RUN) $(COV_CM_DBG) \ 
-tb_gui +ntb_debug_on_start 

both_guis_%: 
$(DUT_SIM_EXEC) $(DUT_SIM_OPTIONS) $(DBG_RUN) $(COV_CM_DBG) \ 
-gui \ 
-tb_gui +ntb_debug_on_start 

new_gui_%:   #打开一个新的 DVE软件窗口？ 
$(DUT_SIM_EXEC) $(DUT_SIM_OPTIONS) $(DBG_RUN) $(COV_CM_DBG) \ 
-gui \ 
-tbug 

pp_%:   #这个命令应该就是打开VPD波形 
dve -vpd $(OUTPUT_DIR)/$(TB_TEST_ID).vpd 

urg:    #执行代码覆盖率操作？  代码覆盖律不是在sim的时候产生的吗（在CMP和SIM的时候都有COV的参数啊）？  这个要具体查一下 
urg $(COV_DBG_DATA)   -report $(COV_DIR)/debug/urgReport -lca 
mozilla $(DIR)/$(COV_DIR)/debug/urgReport/dashboard.html & 

dve_cov:                 #该命令应该是使用DVE软件查看coverage结果 
@echo "" 
@echo "WARNING: Did you run this command?" 
@echo "" 
@echo " % source ./utils/setup_dve_cov" 
@echo "" 
dve -cov &       

########################################################################## 
# REGRESSION TARGETS 
########################################################################## 
regress_clean: clean 
@rm -rf $(COV_DIR)/* 
@mkdir -p $(COV_DIR)/debug   #怎么把debug的路径也给删除了？ 
@mkdir -p $(COV_DIR)/regress 
@mkdir -p $(LOG_DIR) 
@mkdir -p $(OUTPUT_DIR) 

regress_build_%:    #regress compile 的时候就$(REG_CMP)和debug不同仔细检查两者的差异 
echo $(COV_TREE) > $(COV_HIER); 
vcs $(TB_CMP_OPTIONS) $(DUT_CMP_OPTIONS) \ 
      $(DUT_SRC) \ 
      $(TB_SRC) \ 
      $(SVA_SRC) \ 
      $(SVA_OPTIONS) \ 
      $(COV_CM_REG) \ 
      $(REG_CMP) 

regress_run_%:   #观察各参数和debug流程的有什么差异 
$(DUT_SIM_EXEC) $(DUT_SIM_OPTIONS) $(REG_RUN) $(COV_CM_REG)

 


regress_urg:    #看来VPD是SIM时产生的，但是覆盖率不是SIM时产生的，可能因为覆盖律要跑多个case才有意义 
urg $(COV_REG_DATA) -grade -report $(COV_DIR)/regress/urgReport 
mozilla $(DIR)/$(COV_DIR)/regress/urgReport/dashboard.html & 

regress_dve_cov: 
@echo "" 
@echo "WARNING: Did you run this command?" 
@echo "" 
@echo " % source ./utils/setup_dve_cov" 
@echo "" 
dve -cov & 
# 综上，debug和regress流程类似，都是四步，compile，sim，urg，dve_cov 
########################################################################## 
# ADMINISTRATIVE   管理命令 
########################################################################## 
help: 
@echo ======================================================================= 
@echo   "        " 
@echo   " USAGE: %make target_name_* <SEED=xxx> <DEFINES=xxxx>             " 
@echo   "        " 
@echo   " ------------------------ DEBUG TARGETS ----------------------------" 
@echo   " test_*       => Compile TB and DUT files, runs the simulation.   " 
@echo   " clean           => Clean the intermediate files.                " 
@echo   " compile_*    => Compile the TB and DUT.                      " 
@echo   " run_*           => Run the simulation.                             " 
@echo   " gui_*           => Run simulation interactively with DVE.       " 
@echo   " tb_gui_*        => Runs simulation interactively with TB Debugger. " 
@echo   " both_guis_*     => Run both debuggers.                             " 
@echo   " new_gui_*    => Run new integrated debuggers.                " 
@echo   " pp_*          => Post process VPD with DVE.                   " 
@echo   " urg          => Make a coverage report for debug runs.       " 
@echo   " dve_cov       => Brings up DVE for coverage reporting.           " 
@echo   "                                                                    " 
@echo   " ----------------------- REGRESSION TARGETS ------------------------" 
@echo   " regress_test_*   => Compile and run with coverage.                " 
@echo   " regress_clean => Remove all coverage files.                   " 
@echo   " regress_build_* => Build test_*.                                   " 
@echo   " regress_run_* => Run test * collecting coverage information.     " 
@echo   " regress_urg     => Make a coverage report for regression runs.     " 
@echo   " regress_dve_cov => Brings up DVE for coverage reporting.           " 
@echo   "                                                                    " 
@echo   " -------------------- ADMINISTRATIVE TARGETS -----------------------" 
@echo   " help           => Displays this message.                         " 
@echo   " init           => Clean all files, including coverage files.    " 
@echo   " tar          => Tar and zip kit and place at ../                 " 
@echo   "        " 
@echo   " e.g.   gmake test_1                                              " 
@echo ======================================================================= 

tar: clean 
cd ..; \ 
tar cvf ${DIR}.tar ${DIR}; \ 
rm -f ${DIR}.tgz; \ 
gzip ${DIR}.tar; \ 
mv ${DIR}.tar.gz ${DIR}.tgz 

clean: 
@rm -rf $(OUTPUT_DIR)/*   $(COV_DIR)/debug/* $(LOG_DIR)/* ./DVEfiles 
@rm -rf urgReport *.tcl *.tcl.old vc_hdrs.h   testbench_debugger_rc 
@rm -rf ucli.key vcs.key vera_debugger_rc .vera_debugger_rc.lock 
@rm -rf .test* .vlog* .dummyDir *.db *.vdb verilog.dump 
@rm -rf ._* .dw* *.log 

init: regress_clean 
@rm -rf include 
@rm -rf examples
# 总结：

# 经过研究，首先使用VCS验证的流程是：

# 1.       对各个源文件（包括DUT和TB）进行编译，生成可执行文件（默认名字为simv）

# 2.       执行simv文件进行仿真，这时会将testcase的仿真结果输出，包括VPD（若开启了VPD dumpping）文件等输出文件

# 3.       若进行代码覆盖率检查，在simv后可以使用urg命令收集覆盖率信息（须跑多个case）

# Makefile 完成的功能是：

# 1.       对源文件的管理：主要是将DUT文件和TB文件以及一些必要的文件的路径写入变量（$DUT_SRC_DIR $TB_SRC_DIR等），还有include的路径（供VCS搜索）。在使用VCS命令进行编译时，可以将该路径加入命令中。我们可以使用脚本将需要编译的文件输出为一个file_list.f文件，然后用vcs –f file_list.f 进行编译。

# 2.       对路径的管理：将源文件路径和输出文件路径写入各自的变量，一遍在后边使用vcs命令时调用。

# 3.       对VCS命令参数的调整：这部分是重要的步骤，根据需要的不同（debug和regress的需要就不相同），参数设置也有不同，但有一些参数是不管怎样的流程都需要的，在我们的验证平台中，我们可以将参数分为两部分，一部分是都需要的可以公用的，一部分是可以灵活使用的，可以更改的。

# 4.       对VCS命令的调整：这部分就是将VCS的几个主要命令（其实就是VCS  和 SIMV）加上对应的参数设置。我们的验证平台可以将不同的命令写成不同的脚本，然后写一个总的脚本进行调用。

# 5.       其实需要灵活配置的主要就是VPD文件和覆盖率的设置（VPD 在rtl级实际上应该每次都生成）