`include "package.svh"
interface valid_ready_intf #(parameter N = 4, V = 0) (input m_clk);
   // Clock and Reset
   logic clk;
   logic rst;

   // Add all the signals
   logic [N-1:0] up_data, dwn_data;
   logic	 up_vld, dwn_vld;
   logic	 up_rdy, dwn_rdy;
   
   // Transaction counter
   logic [63:0] cnt;
   //
   logic	task_end;

   assign clk = m_clk;
   
   task reset();
      rst <= 1'b1;
      repeat (5) @(posedge clk);
      rst <= 1'b0;
   endtask // reset

   task run();
      task_end <= 0;
      
      $display("---------------------------------------------------------------");
      if(V==1)
	$display("------------------------- Version 1 ---------------------------");
	  else    
	$display("------------------------- Version 2 ---------------------------");
      $display("---------------------------------------------------------------");
      
      // constant dwn_vld
      $display("------------------- DWN VLD = 1 and UP RDY = 1 ----------------");
      dwn_vld <= 1'b1;
      up_rdy  <= 1'b1;
      repeat (16) @(posedge clk);
      
      // toggle dwn_vld with up_rdy constant
      $display("---------------- DWN VLD = TOGGLES and UP RDY = 1 --------------");
      up_rdy <= 1'b1;
      for(int i=0; i<16; i= i+1)begin
         dwn_vld <= 1'b0;
         @(posedge clk);
         dwn_vld <= 1'b1;
         @(posedge clk);
      end
      
      // constant dwn_vld with toggaling up_rdy
      $display("---------------- DWN VLD = 1 and UP RDY = TOGGLES --------------");
      dwn_vld <= 1'b1;
      for(int i=0; i<16; i= i+1)begin
         up_rdy <= 1'b0;
         @(posedge clk);
         up_rdy <= 1'b1;
         @(posedge clk);
      end
      
      // random
      $display("-------------- DWN VLD = RANDOM and UP RDY = RANDOM -------------");
      for(int i=0; i<16; i= i+1)begin
         dwn_vld <= $random();
         up_rdy  <= $random();
         @(posedge clk);
         dwn_vld <= $random();
         up_rdy  <= $random();
         @(posedge clk);
      end
     
      task_end <= 1;
      @(posedge clk);
 
      $display("---------------------------------------------------------------");
      $display("Total No. of Transactions = %0d", cnt);
      $display("---------------------------------------------------------------");
   endtask // run

 task back_pressure();
      task_end <= 0;
      
      $display("---------------------------------------------------------------");
      $display("------------------------ Valid  Ready -------------------------");
      $display("------------------------ Backpressure -------------------------");

      // fill pipeline
      $display("------------------- DWN VLD = 1 and UP RDY = 1 ----------------");
      dwn_vld <= 1'b1;
      for(int i=0; i<32; i= i+1)begin
         up_rdy <= 1'b1;
         @(posedge clk);
	 up_rdy <= 1'b0;
	 #(2*`T) @(posedge clk);
      end

      // generate stalls
      $display("---------------- DWN VLD = 1 and UP RDY = RANDOM --------------");
      dwn_vld <= 1'b1;
      for(int i=0; i<32; i= i+1)begin
         up_rdy <= $random();
         @(posedge clk);
      end

      // flush pipeline
      dwn_vld <= 1'b0;
      up_rdy  <= 1'b1;
      while(up_vld) @(posedge clk);

      task_end <= 1;
      @(posedge clk);
      
      $display("---------------------------------------------------------------");
      $display("Total No. of Transactions = %0d", cnt);
      $display("---------------------------------------------------------------"); 
   endtask // back_pressure 
 
 
   // data generation
   always_ff@(posedge clk)begin
    if(rst)
        dwn_data <= 0;
    else begin
      if(dwn_rdy & dwn_vld)
	dwn_data <= $random();
	end
   end
   
   // verification
   logic [N-1:0] queue [$];
   logic [N-1:0] exp_res;
   
   always@(posedge clk)begin
      if(rst)begin
	 queue.delete();
      end else begin
	 if(dwn_rdy & dwn_vld)
	   queue.push_back(dwn_data);
      
	 if(up_vld & up_rdy)begin
	    if(queue.size() == 0)begin
               $error("Failure Queue Empty ;(");
               $finish;
	    end else begin
               exp_res = queue.pop_front();
               if(exp_res == up_data)
		 $display("PASS :: DWN DATA = %d and UP DATA = %d", exp_res, up_data);
               else begin
		  $error("FAIL :: DWN DATA = %d and UP DATA = %d", exp_res, up_data);
		  $finish;
               end
	    end
	 end
      end
   end
   
   // count the number of transactions
   always_ff@(posedge clk)begin
      if(rst)
	cnt <= '0;
      else begin
	 if(task_end)
	   cnt <= '0;
	 else if(dwn_rdy & dwn_vld)
	   cnt <= cnt + 1;
      end
   end
   
endinterface // valid_ready_intf
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
