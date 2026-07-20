`include "defines.sv"
class apb_environment;
virtual apb_interface.DRV drv_vif;
virtual apb_interface.MON mon_vif;

mailbox #(apb_transaction) mbx_gd;
mailbox #(apb_transaction) mbx_ms;

apb_generator   gen;
apb_driver      drv;
apb_monitor     mon;
apb_scoreboard  scb;

function new(virtual apb_interface.DRV drv_vif,
	     virtual apb_interface.MON mon_vif);
    this.drv_vif=drv_vif;
    this.mon_vif=mon_vif;
    
endfunction


task build();
 begin
 mbx_gd=new();
 mbx_ms=new();
 gen=new(mbx_gd);
 drv=new(mbx_gd,drv_vif);
 mon =new(mon_vif,mbx_ms);
 scb= new(mbx_ms);
 end
endtask
task start();
   fork
      begin
         fork
            gen.start();
            begin drv.start(); repeat(2) @(posedge mon_vif.mon_cb ); end
         join      
      end

      mon.start();
      scb.start();
   join_any
   scb.results();
   disable fork;
endtask

endclass
