`include "defines.sv"

interface apb_interface(input bit clk,input bit PRESETn);
bit transfer,write_read,transfer_done,error,PENABLE,PWRITE,PSLVERR, PREADY,PSEL;
bit [`ADDR_WIDTH-1:0] addr_in,PADDR;
bit [`DATA_WIDTH -1:0]wdata_in,rdata_out,PWDATA,PRDATA;
bit [(`DATA_WIDTH/8) -1:0]strb_in,PSTRB;


clocking drv_cb @ (posedge clk);
 default input #0 output #0;
 output transfer, write_read, addr_in,wdata_in, strb_in,PSLVERR,PREADY,PRDATA;
 input PRESETn, PSEL, PENABLE,transfer_done;
endclocking

clocking mon_cb @(posedge clk);
 default input #0 output #0;
 input rdata_out, transfer_done,error,PADDR,PSEL,PWDATA,PENABLE,PSTRB,PWRITE,PSLVERR,PREADY,PRDATA;
 input transfer,write_read,addr_in, wdata_in, strb_in; 
 
endclocking
 /*
clocking mon_in_cb @(posedge clk);
 default input #0 output #0;
 input transfer,write_read,addr_in, wdata_in, strb_in, PSLVERR, PREADY , PRDATA; 
 input PRESETn, PSEL, PENABLE;
endclocking
*/
modport DRV (clocking drv_cb);
modport MON (clocking mon_cb);
//modport MON_IN( clocking mon_in_cb);
endinterface
