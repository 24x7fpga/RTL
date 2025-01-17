`include "package.svh"
interface race_condition_intf #(parameter N = 4) (input m_clk);
   // Clock and Reset
   logic clk;
   logic rst;
  
   // Add all the signals
   logic [N  :0] res;
   logic         res_vld;
   logic [N-1:0] a,b;
   logic	 arg_vld;

   logic	 task_end;

   // assign clock
   assign clk = m_clk;

   task reset();
      rst <= 1'b1;
      repeat (2) @(posedge m_clk);
      rst <= 1'b0;
   endtask // reset

   task run();
      task_end <= 0;

      $display("-------------- Start Simulation --------------");

      for (int i=0; i<16; i++)begin
	 arg_vld <= $random();
	 @(posedge clk);
      end
/*
      arg_vld <= 1'b0;
      @(posedge clk);
 */     
      task_end = 1;
      @(posedge clk);

      $display("-------- End Simulation: Active Region -------");  // active region
      $strobe("------- End Simulation: Postpone Region ------");  // postpone region
   endtask // run

   // data generation
   always@(posedge clk)begin
      if(rst)begin
	 a <= '0;
	 b <= '0;
      end else begin
	 if(arg_vld)begin
	    a <= $random();
	    b <= $random();
	 end
      end
   end // always@ (posedge clk)
   

   // verification
   logic [N:0] queue [$];
   logic [N:0] sum;
   logic [N:0] exp_res;

   assign sum = a + b;
   
   always@(posedge clk)begin
      if(rst)begin
	 queue.delete();
      end else begin
	 if(arg_vld)
	   queue.push_back(sum);

	 if(res_vld)begin
	    if(queue.size() == 0)begin
	       $error("Failure: Queue Empty ;(");
	       $finish;
	    end else begin
	    //exp_res <= queue.pop_front(); // Updated in NBA
	      exp_res  = queue.pop_front(); // Updated in Active
	       if(exp_res == res)           // Evaluated in Active Region
		 $display("PASS :: Exp_Result = %d and Result = %d", exp_res, res);
	       else begin
		  $error("FAIL :: Exp_Result = %d and Result = %d", exp_res, res);
		  $finish;
	       end
	    end // else: !if(queue.size() == 0)
	 end // if (res_vld)
      end // else: !if(rst)
   end // always_ff@ (posedge clk)
   
endinterface // race_condition_intf
