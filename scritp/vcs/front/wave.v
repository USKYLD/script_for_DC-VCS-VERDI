`ifdef FSDB
initial begin
	$fsdbDumpfile("async_fifo.fsdb");
	$fsdbDumpvars();
	$fsdbDumpMDA();
end
`endif

`ifdef VPD
initial begin	
   $vcdpluson();
   $vcdplusmemon;
   $vcdplusdeltacycleon;
   $vcdplusglitchon;

end
`endif

`ifdef VCD
initial begin
$dumpfile ("async_fifo.vcd");
$dumpvars ();
end
`endif  


