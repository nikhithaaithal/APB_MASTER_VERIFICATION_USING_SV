`include "defines.sv"

class apb_scoreboard;
 mailbox #(apb_transaction) mbx_ms;
 apb_transaction mon2sc;
 static int match, mismatch;
 typedef enum {IDLE,SETUP,ACCESS} state_t;
 state_t state=IDLE; 

 function new(mailbox #(apb_transaction) mbx_ms);
  this.mbx_ms=mbx_ms;
 endfunction

 
 task s();
  case(state)
    IDLE:begin
 	  $display("IDLE");
          if(mon2sc.transfer && mon2sc.PSEL && !mon2sc.PENABLE)
           begin
            state=SETUP;
            $display("SETUP");
           end
         end
    SETUP:begin
          if(mon2sc.PENABLE && mon2sc.PSEL)
           begin
            state=ACCESS;
            $display("ACCESS");
           end
         end
    ACCESS:begin
          if(!mon2sc.PREADY)
           $display("WAITING .......");
          else
             begin
             if(mon2sc.PSLVERR  != mon2sc.error)
                $display("SLAVE ERROR MISMATCHED");
             else
              begin
                if(mon2sc.write_read)
                begin 
    
    if(mon2sc.addr_in==mon2sc.PADDR && mon2sc.wdata_in == mon2sc.PWDATA  && mon2sc.strb_in == mon2sc.PSTRB && mon2sc.PWRITE ==1)
    begin
     if(mon2sc.PSLVERR ) $display("SLAVE ERROR");
     else $display("SCOREBOARD WRITE  OUTPUT MATCHED PADDR =%0d , PWDATA =%0d ,PWRITE=%0d",mon2sc.PADDR,mon2sc.PWDATA,mon2sc.PWRITE);
     match ++;
    end
    else
    begin
     $display("MISMATCH IN SCOREBOARD WRITE  OUTPUT PADDR=%0d, PWDATA=%0d, PWRITE=%0d , addr_in=%0d, wdata=%0d ",mon2sc.PADDR,mon2sc.PWDATA,mon2sc.PWRITE, mon2sc.addr_in, mon2sc.wdata_in);
    mismatch ++;
    end
   end
  


  else
   begin
     if(mon2sc.addr_in==mon2sc.PADDR && mon2sc.PRDATA==mon2sc.rdata_out  && mon2sc.PWRITE ==0)
     begin
      if(mon2sc.PSLVERR ) $display("SLAVE ERROR");
     else $display("SCOREBOARD READ OUTPUT MATCHED PADDR =%0h , PRDATA =%0h ,PWRITE=%0d",mon2sc.PADDR,mon2sc.PRDATA,mon2sc.PWRITE);
      match ++;
     end
    else
    begin
     $display("***MISMATCH IN SCOREBOARD READ OUTPUT PADDR=%0h, PRDATA=%0h, PWRITE=%0d , addr_in=%0h, rdata_out=%0h ",mon2sc.PADDR,mon2sc.PRDATA,mon2sc.PWRITE, mon2sc.addr_in, mon2sc.rdata_out);
     mismatch ++;
    end
   end
  $display("SLAVE ERROR matched");
  $display("___________________________________________________________________________________________________________________________");

  end

    if(mon2sc.PREADY  &&  mon2sc.transfer)
     state = SETUP;
   else 
     state = IDLE;
    end
  end
 endcase
endtask

 task results();
 $display("**************************************************************************");
  $display("Number of MATCHES     : %d",match);
  $display("Number of MISMATCHES  : %d",mismatch);
 $display("**************************************************************************");
 endtask

task start();
 forever begin
  mbx_ms.get(mon2sc);
  s();
 end
endtask 
 
endclass
