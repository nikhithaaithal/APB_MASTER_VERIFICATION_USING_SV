`include "defines.sv"
`include "apb_master.sv"
`include "apb_pkg.sv"
`include "apb_interface.sv"


module top();
 import apb_pkg ::*;
 bit clk;
 bit PRESETn;
 
 initial begin
 forever #10 clk=~clk;
  end
 initial begin
 @(posedge clk)
 PRESETn =0;
 repeat (1) @(posedge clk);
 PRESETn=1;
 end

apb_interface inf(clk,PRESETn);
apb_master duv(inf.clk,inf.PRESETn,inf.PADDR,inf.PSEL,inf.PENABLE,inf.PWRITE,inf.PWDATA,inf.PSTRB,
               inf.PRDATA,inf.PREADY,inf.PSLVERR,inf.transfer,inf.write_read,inf.addr_in,inf.wdata_in,
               inf.strb_in,inf.rdata_out,inf.transfer_done,inf.error);

apb_test  tb  ;
apb_test1 tb1 ;
apb_test2 tb2 ;
apb_test3 tb3 ;
apb_test4 tb4 ;
apb_test5 tb5 ;
apb_test6 tb6 ;
apb_test7 tb7 ;
apb_test8 tb8 ;
apb_test9 tb9 ;
apb_test10 tb10;
test_regression tb_regression;



initial
   begin
    tb  = new(inf.DRV,inf.MON);
    tb.run();
    tb1 = new(inf.DRV,inf.MON);
    tb2 = new(inf.DRV,inf.MON);
    tb3 = new(inf.DRV,inf.MON);
    tb4 = new(inf.DRV,inf.MON);
    tb5 = new(inf.DRV,inf.MON);
    tb6 = new(inf.DRV,inf.MON);
    tb7 = new(inf.DRV,inf.MON);
    tb8 = new(inf.DRV,inf.MON);
    tb9 = new(inf.DRV,inf.MON);
    tb10 = new(inf.DRV,inf.MON);
    tb_regression = new(inf.DRV,inf.MON);

    tb_regression.run();
    $finish();
   end
endmodule


