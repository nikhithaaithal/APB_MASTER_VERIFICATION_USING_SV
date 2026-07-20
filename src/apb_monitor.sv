`include "defines.sv"
class apb_monitor;
 apb_transaction mon_trans;
 mailbox #(apb_transaction) mbx_ms;
 virtual apb_interface.MON  vif;
 
 //covergroup mon_cg;s

 //endgroup

 function new(virtual apb_interface.MON vif, mailbox #(apb_transaction) mbx_ms);
   this.vif=vif;
   this.mbx_ms=mbx_ms;
   //mon_cg=new();
 endfunction
 
 task start();
  repeat(4) @ (vif.mon_cb);
  //for(int i=0;i<`NUM_TRANSACTION;i++)
  forever 
   begin
   @(vif.mon_cb);
   mon_trans=new();
   //do 
    //@(vif.mon_cb);
   //while(!(vif.mon_cb.transfer_done));
   //while(!(vif.mon_cb.PREADY));
   //while(!(vif.mon_cb.PSEL)&& !(vif.mon_cb.PREADY) && !(vif.mon_cb.PENABLE) );
   mon_trans.rdata_out     =vif.mon_cb.rdata_out;
   mon_trans.transfer_done =vif.mon_cb.transfer_done;
   mon_trans.error         =vif.mon_cb.error;
   mon_trans.PADDR         =vif.mon_cb.PADDR;
   mon_trans.PSEL          =vif.mon_cb.PSEL;
   mon_trans.PWDATA        =vif.mon_cb.PWDATA;
   mon_trans.PENABLE       =vif.mon_cb.PENABLE;
   mon_trans.PWRITE        =vif.mon_cb.PWRITE;
   mon_trans.PSTRB         =vif.mon_cb.PSTRB;

   mon_trans.transfer    = vif.mon_cb.transfer;
   mon_trans.write_read  = vif.mon_cb.write_read;
   mon_trans.addr_in     = vif.mon_cb.addr_in;
   mon_trans.wdata_in    = vif.mon_cb.wdata_in;
   mon_trans.strb_in     = vif.mon_cb.strb_in;
   mon_trans.PSLVERR     = vif.mon_cb.PSLVERR;
   mon_trans.PREADY      = vif.mon_cb.PREADY;
   mon_trans.PRDATA      = vif.mon_cb.PRDATA;
   
  $display("%t :MONITOR PASSING THE DATA OUT TO SCOREBOARD PSEL=%0d,PADDR=%0h, PWDATA=%0h, PENABLE=%0d,PWRITE=%0d,PSTRB=%0b,rdata_out=%0h ,transfer_done=%0d, error=%0d",$time,mon_trans.PSEL,mon_trans.PADDR, mon_trans.PWDATA, mon_trans.PENABLE,mon_trans.PWRITE,mon_trans.PSTRB,mon_trans.rdata_out ,mon_trans.transfer_done, mon_trans.error);
  mbx_ms.put(mon_trans);
$display("///////////////////////////////////output monitor////////////////////////////");

  //mon_cg.sample();
  //$display("OUTPUT COVERAGE");
  end
 endtask
endclass
