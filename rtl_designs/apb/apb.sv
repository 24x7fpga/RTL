`include "package.svh" 
module apb(/*AUTOARG*/
   // Outputs
   m_paddr, m_pwdata, m_pselx, m_en, m_pwrite, m_pready, m_prdata,
   // Inputs
   p_addr, pw_data, p_sel, p_wr, trans, pclk, presetn
   );
   // outputs
   output [`WIDTH-1:0] m_paddr;
   output [`WIDTH-1:0] m_pwdata;
   output [3:0]	       m_pselx;
   output	       m_en;
   output	       m_pwrite;
   output	       m_pready;
   output [`WIDTH-1:0] m_prdata; 
   
   // inputs
   // interface signals
   input [`WIDTH-1:0]  p_addr;
   input [`WIDTH-1:0]  pw_data;
   input [3:0]	       p_sel;
   input	       p_wr;
   input	       trans;
   // APB signals
   input	       pclk;
   input	       presetn;
   
   logic [`WIDTH-1:0]  prdata;
 
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			p_ready;		// From MSTR of apb_master.v
   wire [`WIDTH-1:0]	paddr;			// From MSTR of apb_master.v
   wire			penable;		// From MSTR of apb_master.v
   logic		pready;			// From CTRL of apb_ctrl.v
   wire [3:0]		pselx;			// From MSTR of apb_master.v
   wire			pslverr;		// From MSTR of apb_master.v
   wire [`WIDTH-1:0]	pwdata;			// From MSTR of apb_master.v
   wire			pwrite;			// From MSTR of apb_master.v
   wire [`WIDTH-1:0]	rd_data;		// From MSTR of apb_master.v
   // End of automatics
 
   apb_master MSTR (/*AUTOINST*/
		    // Outputs
		    .paddr		(paddr[`WIDTH-1:0]),
		    .pwdata		(pwdata[`WIDTH-1:0]),
		    .pselx		(pselx[3:0]),
		    .penable		(penable),
		    .pwrite		(pwrite),
		    .pslverr		(pslverr),
		    .rd_data		(rd_data[`WIDTH-1:0]),
		    .p_ready		(p_ready),
		    // Inputs
		    .pclk		(pclk),
		    .presetn		(presetn),
		    .pready		(pready),
		    .p_addr		(p_addr[`WIDTH-1:0]),
		    .pw_data		(pw_data[`WIDTH-1:0]),
		    .p_sel		(p_sel[3:0]),
		    .p_wr		(p_wr),
		    .trans		(trans)); 

   apb_ctrl CTRL (/*AUTOINST*/
		  // Outputs
		  .pready		(pready),
		  .prdata		(prdata[`WIDTH-1:0]),
		  // Inputs
		  .paddr		(paddr[`WIDTH-1:0]),
		  .pwdata		(pwdata[`WIDTH-1:0]),
		  .pselx		(pselx[3:0]),
		  .penable		(penable),
		  .pwrite		(pwrite),
		  .pclk			(pclk),
		  .presetn		(presetn));
   
   // signals for master verification
   assign m_paddr  = paddr;
   assign m_pwdata = pwdata;
   assign m_pselx  = pselx;
   assign m_en     = penable;
   assign m_pwrite = pwrite;
   assign m_pready = p_ready;
   assign m_prdata = prdata;
   
  
endmodule 
// Local Variables: 
// Verilog-Library-Directories:("~/Projects/FPGA_Projects/iVerilog/design/apb/" ".") 
// End:
