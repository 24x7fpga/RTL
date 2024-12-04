module apb_master(/*AUTOARG*/
   // Outputs
   paddr, pwdata, pselx, penable, pwrite, pslverr, rd_data, p_ready,
   // Inputs
   pclk, presetn, pready, p_addr, pw_data, p_sel, p_wr, trans
   );
   // outputs
   // APB signals
   output [`WIDTH-1:0] paddr;
   output [`WIDTH-1:0] pwdata;
   
   output [3:0]	       pselx;       // maximum of 16 slaves
   output	       penable;
   output	       pwrite;
   output	       pslverr;
   // interface signals
   output [`WIDTH-1:0] rd_data;
   output	       p_ready;
   
   // inputs
   // APB signals
   input	       pclk;
   input	       presetn;
   input	       pready;
   // interface signals
   input [`WIDTH-1:0]  p_addr;
   input [`WIDTH-1:0]  pw_data;
   input [3:0]	       p_sel;
   input	       p_wr;
   input	       trans;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [`WIDTH-1:0]	paddr;
   reg			penable;
   reg [3:0]		pselx;
   reg			pslverr;
   reg [`WIDTH-1:0]	pwdata;
   reg			pwrite;
   reg [`WIDTH-1:0]	rd_data;
   // End of automatics
   /*AUTOWIRE*/

   typedef enum logic [1:0] {idle, setup, access} state_type;
   state_type st_reg, st_nxt;

   // fsm sequential logic
   always_ff@(posedge pclk)
     if(!presetn)
       st_reg <= idle;
     else
       st_reg <= st_nxt;

   // fsm combinational logic
   always_comb begin
      st_nxt = st_reg;   
      case(st_reg)

	idle: begin
	   pselx   = 0;
	   penable = 0;
	   paddr   = 0;
	   pwdata  = 0;
	   pwrite  = 0;
	   if(trans)
	     st_nxt = setup;
	   else
	     st_nxt = idle;
	end // case: idle

	setup: begin
	   pselx   = p_sel;
	   penable = 0;
	   paddr   = p_addr;
	   pwdata  = pw_data;
	   pwrite  = p_wr;
	   st_nxt  = access;
	end // case: setup

	access: begin
	   pselx   = p_sel;
	   penable = 1;
	   paddr   = p_addr;
	   pwdata  = pw_data;
	   pwrite  = p_wr;
	   if(!pready)begin
	      st_nxt = access;
	   end else begin
	     if(trans)
	       st_nxt = setup;
	     else
	       st_nxt = idle;
	   end
	end // case: access

      endcase // case (st_reg)
   end // always_comb

   assign p_ready = pready;
 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/apb" ".")
// End:
