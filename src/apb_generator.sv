`include "defines.sv"

class apb_generator;
 apb_transaction blueprint;
 mailbox #( apb_transaction) mbx_gd;
 function new(mailbox #(apb_transaction )mbx_gd);
   this.mbx_gd=mbx_gd;
    blueprint = new();
 endfunction
 task start();
   for(int i=0; i< `NUM_TRANSACTION; i++)
    begin
    assert(blueprint.randomize());
    mbx_gd.put( blueprint.copy());
    $display("GENERATOR randomized transaction: transfer= %0d ,write_read =%0d ,addr_in=%0h , wdata_in=%0h, strb_in=%b,PSLVERR=%0d , PREADY=%0d, PRDATA=%0h",blueprint.transfer ,blueprint.write_read ,blueprint.addr_in , blueprint.wdata_in, blueprint.strb_in,blueprint.PSLVERR , blueprint.PREADY, blueprint.PRDATA);
    end
 endtask
endclass
