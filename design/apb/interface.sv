`include "package.svh"
interface apb_intf(input clk);
   
   logic [`WIDTH-1:0] p_addr;
   logic [`WIDTH-1:0] pw_data;
   logic [3:0]	      p_sel;
   logic	      p_wr;
   logic	      trans;
   logic	      pready;
   logic	      pclk;
   logic	      presetn;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire		      m_en;			// From DUT of apb.v
   wire [`WIDTH-1:0]  m_paddr;		// From DUT of apb.v
   wire	[`WIDTH-1:0]   m_prdata;		// From DUT of apb.v
   wire [3:0]	      m_pselx;		// From DUT of apb.v
   wire [`WIDTH-1:0]  m_pwdata;		// From DUT of apb.v
   wire		      m_pwrite;		// From DUT of apb.v
   wire		      m_pready;			// From DUT of apb.v
   // End of automatics
   
   assign pclk = clk;
   
   logic rst;
   
   // generate reset
   task reset();
      rst <= 0;
      repeat(3) @(posedge clk);
      rst <= 1;
   endtask // reset
   // assign rst to DUT reset
   assign presetn = rst;

   // set baud rate
   task m_br(logic [10:0] br_dvsr);
      p_addr  <= `DVSR;
      pw_data <= {21'h0, br_dvsr};
      p_sel   <= 4'h3;
      p_wr    <= 1'h1;
      trans   <= 1'h1;
      @(posedge clk);
	
      while(!(m_pready & m_en))
	 @(posedge clk);

      disp();
      @(posedge clk);
   endtask // m_no_wait_test

    task send(logic [7:0] data);
       // send data signal
       p_addr  <= `TX_DIN;
       pw_data <= {28'h0, data};
       p_sel    <= 4'h3;
       p_wr    <= 1'h1;
       trans   <= 1'h1;
       @(posedge clk);
 
       while(!(m_pready & m_en))
	 @(posedge clk);
 
       disp();
       @(posedge clk);

        // send start signal
        p_addr  <= `TX_START;
        pw_data <= 32'h01;
        p_sel    <= 4'h3;
        p_wr    <= 1'h1;
        @(posedge clk);
  
       while(!(m_pready & m_en))
	 @(posedge clk);
       
        disp(); 
        @(posedge clk); 

     
        // send start signal
        p_addr  <= `TX_START;
        pw_data <= 32'h0;
        p_sel    <= 4'h3;
        p_wr    <= 1'h1;
        @(posedge clk);
  
       while(!(m_pready & m_en))
	 @(posedge clk);
       
        disp(); 
        @(posedge clk); 
    endtask
     
   task read_status();
      p_addr <= `TX_BUSY;
      p_sel  <= 4'h3;
      p_wr   <= 1'h0;
      trans  <= 1'h1;
      @(posedge clk);

      while(!(m_pready & m_en))
	@(posedge clk);
     
      disp();
      
      while(m_prdata[0])
	@(posedge clk);
 
      // $display("tx busy = %d", m_prdata[0]);
      @(posedge clk);

      
      p_addr <= `RX_BUSY;
      p_sel  <= 4'h3;
      p_wr   <= 1'h0;
      trans  <= 1'h1;
      @(posedge clk);

      while(!(m_pready & m_en))
	@(posedge clk);

      disp();
      
      while(m_prdata[0])
	@(posedge clk);
 
      // $display("rx busy = %d", m_prdata[0]);
      @(posedge clk);
 
   endtask // read_status

   
   task read();
      p_addr <= `RX_DOUT;
      p_sel  <= 4'h3;
      p_wr   <= 1'h0;
      trans  <= 1'h1;
      @(posedge clk);

      while(!(m_pready & m_en))
	@(posedge clk);
 
      $display("Read data = %d", m_prdata[7:0]);
      @(posedge clk);
 
   endtask // read_status

   
   // checking output data
   // come up with a better logic
   logic [`WIDTH-1:0] assoc [72:0];
  
    
    always @(posedge clk) begin
	 if(rst) 
	    assoc[p_addr] <= pw_data;
      end // always @ (posedge clk)
   
   function void disp();      
      if(m_en && m_pready && p_wr)begin
	 if(assoc[p_addr] == assoc[m_paddr])
	   $display("s.addr = %d, s.data = %d <==> r.addr = %d, r.data = %d :: PASS ;)", p_addr, assoc[p_addr], m_paddr, assoc[m_paddr]);
	 else
	   $display("s.addr = %d, s.data = %d <==> r.addr = %d, r.data = %d :: FAIL ;(", p_addr, assoc[p_addr], m_paddr, assoc[m_paddr]);
      end
   endfunction // disp
   
   
      

endinterface // apb_intf

