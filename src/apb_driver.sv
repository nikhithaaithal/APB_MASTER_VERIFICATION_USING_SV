`include "defines.sv"

class apb_driver;
 apb_transaction drv_trans;
 mailbox #(apb_transaction) mbx_gd;
 virtual apb_interface.DRV vif;

 
 covergroup drv_cg;
  transfer_cp   :coverpoint drv_trans.transfer {bins b1[]={0,1};}
  write_read_cp :coverpoint drv_trans.write_read {bins b2[]={0,1};}
  strb_in_cp    :coverpoint drv_trans.strb_in{
    bins no_strobe    = {4'b0000};
    bins valid_strobe []= {[4'b0001:4'b1111]};
    }
  addr_in_cp    :coverpoint drv_trans.addr_in
                        {
                         bins low  = {[0:63]};
                         bins mid  = {[64:127]};
                         bins high = {[128:255]};
                         }
  wdata_cp      :coverpoint drv_trans.wdata_in;
  pslverr_cp    :coverpoint drv_trans.PSLVERR;
  pready_cp     :coverpoint vif.drv_cb.PREADY;
  prdata_cp     :coverpoint drv_trans.PRDATA{
                         bins d_low  = {[32'h0000_0000:32'h7fff_ffff]};
                         bins d_mid  = {[32'h8000_0000:32'hffff_ffff]};
                         }

  //cross coverage
  write_read_cpxaddr_in_cp :cross write_read_cp ,addr_in_cp;
  write_read_cpxwdata_cp   :cross write_read_cp ,wdata_cp;
  write_read_cpxstrb_in_cp :cross write_read_cp ,strb_in_cp ;
  write_read_cpxpslverr_cp :cross write_read_cp ,pslverr_cp; 
 

 endgroup
 
 function new(mailbox #(apb_transaction) mbx_gd, virtual apb_interface.DRV vif);
  this.mbx_gd= mbx_gd;
  this.vif= vif; 
  drv_cg=new();
 endfunction
 
 task start();
  repeat(3) @(vif.drv_cb);
  for( int i=0;i<`NUM_TRANSACTION;i++)
   begin
   drv_trans =new();
   mbx_gd.get(drv_trans);
   if( vif.drv_cb.PRESETn == 0)
    repeat(1) @(vif.drv_cb)
    begin
    vif.drv_cb.transfer<=0 ;
    vif.drv_cb.write_read<=0;
    vif.drv_cb.addr_in<=0; 
    vif.drv_cb.wdata_in<=0;  
    vif.drv_cb.strb_in<=0; 
    vif.drv_cb.PSLVERR <=0;  
    vif.drv_cb.PREADY<=0; 
    vif.drv_cb.PRDATA<=0; 
     $display("reset");

    end
   else
    begin 
     fork
      begin
      repeat(1) @(vif.drv_cb);
      vif.drv_cb.transfer    <= drv_trans.transfer;
      vif.drv_cb.strb_in     <= drv_trans.strb_in;
      vif.drv_cb.write_read  <= drv_trans.write_read;
      vif.drv_cb.addr_in     <= drv_trans.addr_in;
      vif.drv_cb.wdata_in    <= drv_trans.wdata_in;
      vif.drv_cb.PREADY<=0;
      $display("Transaction number:%d",i+1);
      if(drv_trans.transfer ==1)begin
      do
       @(vif.drv_cb);
      while(!(vif.drv_cb.PSEL && vif.drv_cb.PENABLE));
      repeat(drv_trans.wait_states -1) @(vif.drv_cb);//wait states

      @(vif.drv_cb)
      vif.drv_cb.PREADY<=1;
      vif.drv_cb.PSLVERR    <=drv_trans.PSLVERR;  
      vif.drv_cb.PRDATA     <=drv_trans.PRDATA;
      end

    $display(" %t:DRIVER WRITE OPERATION AFTER WAIT STATES:transfer=%0d write_read=%0d addr_in=%0h wdata_in=%0h strb_in=%b PSLVERR=%0d PREADY=%0d PRDATA=%0h PSEL =%0d,PENABLE=%0d",
                  $time,drv_trans.transfer, vif.drv_cb.write_read, vif.drv_cb.addr_in,
                  vif.drv_cb.wdata_in, vif.drv_cb.strb_in, vif.drv_cb.PSLVERR,
                  vif.drv_cb.PREADY, vif.drv_cb.PRDATA,vif.drv_cb.PSEL,vif.drv_cb.PENABLE);
     if(drv_trans.wait_states!=0)$display("Number of wait state=%d",drv_trans.wait_states -1 );
     vif.drv_cb.transfer    <= 0;
    drv_cg.sample();
    $display(" INPUT FUNCTIONAL COVERAGE=%d ",drv_cg.get_coverage());
    
    end
    
    begin
       wait (!vif.drv_cb.PRESETn);
    end
    join_any 
    disable fork;
    if( vif.drv_cb.PRESETn == 0)
    repeat(1) @(vif.drv_cb)
    begin
    vif.drv_cb.transfer<=0 ;
    vif.drv_cb.write_read<=0;
    vif.drv_cb.addr_in<=0; 
    vif.drv_cb.wdata_in<=0;  
    vif.drv_cb.strb_in<=0; 
    vif.drv_cb.PSLVERR <=0;  
    vif.drv_cb.PREADY<=0; 
    vif.drv_cb.PRDATA<=0; 
     $display("reset");
    end
   end 
   end
 endtask
endclass
