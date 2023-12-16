.PHONY: dc_full clean dc hold setup

dc_full:
	dc_shell -f ./scripts/top_dc.tcl|tee dc_start.log
clean:
	rm -f *.log *.svf
	rm -rf work unmapped report mapped config alib-52
	cp -r ./rtl/v0.1/*.v ./
	rm -rf rtl
dc:
	dc_shell |tee dc_start.log
hold:
	sed -i 's/slow/fast/g' .synopsys_dc.setup
setup:
	sed -i 's/fast/slow/g' .synopsys_dc.setup

