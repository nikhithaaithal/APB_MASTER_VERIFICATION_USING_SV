class apb_test;
  virtual apb_interface.DRV  drv_vif;
  virtual apb_interface.MON mon_vif; 
  apb_environment env;
  function new(virtual apb_interface.DRV drv_vif,
             virtual apb_interface.MON mon_vif);
    this.drv_vif=drv_vif;
    this.mon_vif=mon_vif;
  endfunction
  task run();
    env=new(drv_vif,mon_vif);
    env.build;
    env.start;
  endtask
endclass

class apb_test1 extends apb_test;
 apb_transaction1 trans;
  function new(virtual apb_interface drv_vif,virtual apb_interface mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    env=new(drv_vif,mon_vif);
    env.build();
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start();
  endtask
endclass


class apb_test2 extends apb_test;
 apb_transaction2 trans;
  function new(virtual apb_interface drv_vif,virtual apb_interface mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    env=new(drv_vif,mon_vif);
    env.build();
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start();
  endtask
endclass

class apb_test3 extends apb_test;
 apb_transaction3 trans;
  function new(virtual apb_interface drv_vif,virtual apb_interface mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    env=new(drv_vif,mon_vif);
    env.build;
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start();
  endtask
endclass

class apb_test4 extends apb_test;
 apb_transaction4 trans;
  function new(virtual apb_interface drv_vif,virtual apb_interface mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    env=new(drv_vif,mon_vif);
    env.build;
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start;
  endtask
endclass


class apb_test5 extends apb_test;
 apb_transaction5 trans;
   function new(virtual apb_interface drv_vif,virtual apb_interface mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    env=new(drv_vif,mon_vif);
    env.build();
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start();
  endtask
endclass


class apb_test6 extends apb_test;
 apb_transaction6 trans;
   function new(virtual apb_interface drv_vif,virtual apb_interface mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    env=new(drv_vif,mon_vif);
    env.build;
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start();
  endtask
endclass


class apb_test7 extends apb_test;
 apb_transaction7 trans;
  function new(virtual apb_interface drv_vif,virtual apb_interface mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    env=new(drv_vif,mon_vif);
    env.build();
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start();
  endtask
endclass


class apb_test8 extends apb_test;
 apb_transaction8 trans;
 function new(virtual apb_interface drv_vif,virtual apb_interface mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    env=new(drv_vif,mon_vif);
    env.build();
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start();
  endtask
endclass



class apb_test9 extends apb_test;
 apb_transaction9 trans;
 function new(virtual apb_interface drv_vif,virtual apb_interface mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    env=new(drv_vif,mon_vif);
    env.build();
    begin 
    trans = new();
    env.gen.blueprint= trans;
    end
    env.start();
  endtask
endclass


class test_regression extends apb_test;
 apb_transaction  trans0;
 apb_transaction1 trans1;
 apb_transaction2 trans2;
 apb_transaction3 trans3;
 apb_transaction4 trans4;
 apb_transaction5 trans5;
 apb_transaction6 trans6;
 apb_transaction7 trans7;
 apb_transaction8 trans8;
 apb_transaction9 trans9;
  function new(virtual apb_interface drv_vif,
               virtual apb_interface mon_vif);
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    env=new(drv_vif,mon_vif);
    env.build;
///////////////////////////////////////////////////////
    begin 
    trans0 = new();
    env.gen.blueprint= trans0;
    end
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    trans1 = new();
    env.gen.blueprint= trans1;
    end
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    trans2 = new();
    env.gen.blueprint= trans2;
    end
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    trans3 = new();
    env.gen.blueprint= trans3;
    end
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    trans4 = new();
    env.gen.blueprint= trans4;
    end
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    trans5 = new();
    env.gen.blueprint= trans5;
    end
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    trans6 = new();
    env.gen.blueprint= trans6;
    end
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    trans7 = new();
    env.gen.blueprint= trans7;
    end
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    trans8 = new();
    env.gen.blueprint= trans8;
    end
    env.start;
//////////////////////////////////////////////////////


///////////////////////////////////////////////////////
    begin 
    trans9 = new();
    env.gen.blueprint= trans9;
    end
    env.start;
//////////////////////////////////////////////////////

  endtask
endclass




