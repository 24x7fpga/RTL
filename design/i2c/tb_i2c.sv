`timescale 1ns/1ns 
module tb_i2c();
   localparam  t = 8;
   localparam  d = 1250;
   
   logic       i_clk;
   logic       i_rst;
   logic       i_wrt;
   logic [7:0] i_data;
   
   /*AUTOREG*/  
   /*AUTOWIRE*/ 
   
   logic sda;
   
   logic       dir;
   logic [3:0] cnt;
   logic [7:0] rx_data;
   
   i2c DUT (
	    // Outputs
	    .o_scl			(o_scl),
	    // Inouts
	    .o_sda			(o_sda),
	    // Inputs
	    .i_clk			(i_clk),
	    .i_rst			(i_rst),
	    .i_wrt			(i_wrt),
	    .i_data			(i_data[7:0])); 
   
   always #(t/2) i_clk = (i_clk === 1'b0);
   
   // model pull registers
   //tri o_sda;
   pullup (o_sda);
   assign o_sda = dir ? sda : 1'bz;
   // model pull registers
   //tri o_scl;
   pullup (o_scl);
   assign o_scl = 1'bz;
   

   
   always_ff@(posedge o_scl)begin
    if(i_rst)begin
        cnt <= 0;
        dir <= 0;
        rx_data <= 0;
        sda <= 1;
    end else begin
        if(cnt <= 7)begin
            rx_data <= {rx_data[6:0], o_sda};
            dir <= 0;
            cnt <= cnt + 1;
        end else begin    
            if(cnt == 8 && rx_data == i_data)begin
                dir <=1;
                sda <=0;
                cnt <= cnt + 1;
                $display("PASS ;) :: Tx = %d, Rx = %d", i_data, rx_data);
            end else if(cnt == 8 && rx_data != i_data) begin
                dir <= 1;
                sda <= 1;
                cnt <= cnt + 1;
                $display("FAIL ;( :: Tx = %d, Rx = %d", i_data, rx_data);
            end 
            if(cnt == 9)begin
                cnt <= 0;
                dir <= 0;
            end
        end
    end
   end
                
   initial begin   
      i_rst  = 1;
      i_data = 8'b10010110;
      i_wrt  = 0;
      #(2*d*t); 
      i_rst  = 0;
      i_wrt  = 1;
      #(2*d*t); 
      i_wrt  = 0;
      #(7*d*t);
//      dir    = 1;
//      sda    = 0;
      #(1.5*d*t);
//      dir    = 0;
      #(2*d*t);
      $finish;
      
   end 
   
   initial begin 
      $dumpfile("tb_i2c.vcd"); 
      $dumpvars(0,tb_i2c); 
   end 

endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/i2c" ".")
// End:
