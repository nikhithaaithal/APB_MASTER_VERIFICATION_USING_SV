`include "defines.sv"

class apb_transaction;
 rand bit transfer,write_read,PSLVERR;
 rand bit [`ADDR_WIDTH-1:0]addr_in;
 rand bit [`DATA_WIDTH -1:0] wdata_in,PRDATA;
 rand bit [((`DATA_WIDTH-1)/8)-1:0] strb_in;
bit PREADY;
rand bit [2:0]wait_states;
 bit transfer_done,error,PENABLE,PWRITE,PSEL;
 bit [`DATA_WIDTH -1:0] rdata_out,PWDATA;
 bit [`ADDR_WIDTH -1:0] PADDR;
 bit [((`DATA_WIDTH-1)/8)-1:0] PSTRB;

 constraint c1{
 if(write_read)
 strb_in inside {[1:15]};
 else
 strb_in == 0;
 wait_states inside {[0:6]};
 
 }
 

 virtual function apb_transaction copy();
   copy = new();
   copy.transfer    = this.transfer;
   copy.addr_in     = this.addr_in;
   copy.write_read  = this.write_read;
   copy.PSLVERR     = this.PSLVERR;
   copy.PREADY      = this.PREADY;
   copy.wdata_in    = this.wdata_in;
   copy.PRDATA      = this.PRDATA; 
   copy.strb_in     = this.strb_in;
   copy.wait_states  = this.wait_states;     
   return copy;
 endfunction

endclass



////////Back to back write operation without wait state////////////////////////
 

class apb_transaction1 extends apb_transaction;
 
 constraint c3{ write_read == 1;}
  constraint w{wait_states == 0;}
 constraint c4{ transfer ==1;}

 virtual function apb_transaction copy();
   apb_transaction1 copy1;
   copy1= new();
   copy1.transfer    = this.transfer;
   copy1.addr_in     = this.addr_in;
   copy1.write_read  = this.write_read;
   copy1.PSLVERR     = this.PSLVERR;
   copy1.PREADY      = this.PREADY;
   copy1.wdata_in    = this.wdata_in;
   copy1.PRDATA      = this.PRDATA; 
   copy1.strb_in     = this.strb_in;
   copy1.wait_states  = this.wait_states;     
   return copy1;
 endfunction

endclass


///////////////back to back read operation without wait state////////////////////////

class apb_transaction2 extends apb_transaction;
 
 constraint c3{ write_read == 0;}
  constraint w{wait_states == 0;}
  constraint c4{ transfer ==1;}

 virtual function apb_transaction copy();
   apb_transaction2 copy2;
   copy2= new();
   copy2.transfer    = this.transfer;
   copy2.addr_in     = this.addr_in;
   copy2.write_read  = this.write_read;
   copy2.PSLVERR     = this.PSLVERR;
   copy2.PREADY      = this.PREADY;
   copy2.wdata_in    = this.wdata_in;
   copy2.PRDATA      = this.PRDATA; 
   copy2.strb_in     = this.strb_in;
   copy2.wait_states  = this.wait_states;     
   return copy2;
 endfunction

endclass

///////////////write then read operation without wait state////////////////////////

class apb_transaction3 extends apb_transaction;
  bit first=1;

 constraint c3{ 
   if(first)
    write_read == 1;
  if(! first)
    write_read == 0;
}

 constraint w{wait_states == 0;}
 constraint c4{ transfer ==1;}

 function void post_randomize();
   first =0;
  endfunction

 virtual function apb_transaction copy();
   apb_transaction3 copy3;
   copy3= new();
   copy3.transfer    = this.transfer;
   copy3.addr_in     = this.addr_in;
   copy3.write_read  = this.write_read;
   copy3.PSLVERR     = this.PSLVERR;
   copy3.PREADY      = this.PREADY;
   copy3.wdata_in    = this.wdata_in;
   copy3.PRDATA      = this.PRDATA; 
   copy3.strb_in     = this.strb_in;
   copy3.wait_states  = this.wait_states;     
   return copy3;
 endfunction

endclass

///////////////read write operation without wait state////////////////////////
class apb_transaction4 extends apb_transaction;
  bit first=1;

 constraint c3{ 
   if(first)
    write_read == 0;
  if(! first)
    write_read == 1;
}
 constraint w{wait_states == 0;}
 constraint c4{ transfer ==1;}

 function void post_randomize();
   first =0;
  endfunction

 virtual function apb_transaction copy();
   apb_transaction4 copy4;
   copy4= new();
   copy4.transfer    = this.transfer;
   copy4.addr_in     = this.addr_in;
   copy4.write_read  = this.write_read;
   copy4.PSLVERR     = this.PSLVERR;
   copy4.PREADY      = this.PREADY;
   copy4.wdata_in    = this.wdata_in;
   copy4.PRDATA      = this.PRDATA; 
   copy4.strb_in     = this.strb_in;
   copy4.wait_states  = this.wait_states;     
   return copy4;
 endfunction

endclass

///////////////Back to back write operation with wait state////////////////////////
class apb_transaction5 extends apb_transaction;
 constraint c3{ write_read == 1;}
 constraint c4{ transfer ==1;}

 virtual function apb_transaction copy();
   apb_transaction5 copy5;
   copy5= new();
   copy5.transfer    = this.transfer;
   copy5.addr_in     = this.addr_in;
   copy5.write_read  = this.write_read;
   copy5.PSLVERR     = this.PSLVERR;
   copy5.PREADY      = this.PREADY;
   copy5.wdata_in    = this.wdata_in;
   copy5.PRDATA      = this.PRDATA; 
   copy5.strb_in     = this.strb_in;
   copy5.wait_states  = this.wait_states;     
   return copy5;
 endfunction

endclass


///////////////Back to back read operation with wait state////////////////////////
class apb_transaction6 extends apb_transaction;
 
 constraint c3{ write_read == 0;}
 constraint c4{ transfer ==1;}

 virtual function apb_transaction copy();
   apb_transaction6 copy6;
   copy6= new();
   copy6.transfer    = this.transfer;
   copy6.addr_in     = this.addr_in;
   copy6.write_read  = this.write_read;
   copy6.PSLVERR     = this.PSLVERR;
   copy6.PREADY      = this.PREADY;
   copy6.wdata_in    = this.wdata_in;
   copy6.PRDATA      = this.PRDATA; 
   copy6.strb_in     = this.strb_in;
   copy6.wait_states = this.wait_states;     
   return copy6;
 endfunction
endclass

///////////////write then read operation with wait state////////////////////////

class apb_transaction7 extends apb_transaction;
  bit first=1;

 constraint c3{ 
   if(first)
    write_read == 1;
  if(! first)
    write_read == 0;
}


 constraint c4{ transfer ==1;}

 function void post_randomize();
   first = 0;
  endfunction

 virtual function apb_transaction copy();
   apb_transaction7 copy7;
   copy7= new();
   copy7.transfer    = this.transfer;
   copy7.addr_in     = this.addr_in;
   copy7.write_read  = this.write_read;
   copy7.PSLVERR     = this.PSLVERR;
   copy7.PREADY      = this.PREADY;
   copy7.wdata_in    = this.wdata_in;
   copy7.PRDATA      = this.PRDATA; 
   copy7.strb_in     = this.strb_in;
   copy7.wait_states  = this.wait_states;     
   return copy7;
 endfunction

endclass

///////////////read write operation with wait state////////////////////////
class apb_transaction8 extends apb_transaction;
  bit first=1;

 constraint c3{ 
   if(first)
    write_read == 0;
  if(! first)
    write_read == 1;
}
 
 constraint c4{ transfer == 1;}

 function void post_randomize();
   first = 0;
  endfunction

 virtual function apb_transaction copy();
   apb_transaction8 copy8;
   copy8= new();
   copy8.transfer    = this.transfer;
   copy8.addr_in     = this.addr_in;
   copy8.write_read  = this.write_read;
   copy8.PSLVERR     = this.PSLVERR;
   copy8.PREADY      = this.PREADY;
   copy8.wdata_in    = this.wdata_in;
   copy8.PRDATA      = this.PRDATA; 
   copy8.strb_in     = this.strb_in;
   copy8.wait_states  = this.wait_states;     
   return copy8;
 endfunction

endclass



////////slave error////////////////////////
 

class apb_transaction9 extends apb_transaction;
 
 constraint c3{ PSLVERR == 1;}


 virtual function apb_transaction copy();
   apb_transaction9 copy9;
   copy9 = new();
   copy9.transfer    = this.transfer;
   copy9.addr_in     = this.addr_in;
   copy9.write_read  = this.write_read;
   copy9.PSLVERR     = this.PSLVERR;
   copy9.PREADY      = this.PREADY;
   copy9.wdata_in    = this.wdata_in;
   copy9.PRDATA      = this.PRDATA; 
   copy9.strb_in     = this.strb_in;
   copy9.wait_states  = this.wait_states;     
   return copy9;
 endfunction


endclass




































