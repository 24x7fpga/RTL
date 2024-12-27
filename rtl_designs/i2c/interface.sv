`include "package.svh"
interface i2c_intf (input i_clk);
   // Reset and clock
   logic        rst_n;
   logic	clk;
   // sda and scl
   wire		sda, scl;
   // Add all the signals
   logic	rd_wr;
   logic	wr;         // addr, cmd and data
   logic [6:0]	addr;
   logic [7:0]	cmd;
   logic [7:0]	data;
   logic [7:0]	rx_data;
   logic [15:0]	o_data;
   // Initiate
   logic	init;
   // Flag Signals
   logic	start, s_busy, s_done;
   logic	rx_ack_en;
   logic	sda_en;
   logic	sda_res; // sda response for receiving data
   

   // testbench signals    
   logic	sda_trans;
   logic	collect;
   // Transmit Verification
   logic [2:0]	col_cnt;
   logic [7:0]	col_data;
   logic [7:0]	slave_cmd;
   logic [7:0]	slave_data;
   // Receive Verification
   logic [3:0]	trn_cnt;
   logic [7:0]	trn_data;
   logic	transmit;
   logic	r;


   // Four Command Registers and their Address
   // temperature register   = 2'b00;
   // configuration register = 2'b01;
   // general register       = 2'b10;
   // default register       = 2'b11;
   
   // register data
   logic [15:0]	temp_data = 16'h1234;
   logic [7:0]	config_data;
   logic [7:0]	general_data;
   logic [15:0]	default_data = 16'h9821;
   
   logic [15:0]	trans_data;
    
    
assign clk = i_clk;

   task reset();
      rst_n <= 1'b0;
      repeat (`DVSR) @(posedge i_clk);
      rst_n <= 1'b1;
   endtask // reset

   task write(logic [6:0] sl_addr, logic [7:0] sl_cmd, logic [7:0] sl_data);
      init    <= 1;
      sda_res <= 0;
      rd_wr   <= 0;
      wr      <= 1;
      addr    <= sl_addr;
      cmd     <= sl_cmd;
      data    <= sl_data;
      collect <= 1'b0;
      // Transmit Slave Address
      $display("------------ Transmit Slave Address ------------");
      @(posedge clk);
      init      <= 0;
      wait(s_busy);
      collect   <= 1'b1;
      @(posedge clk);
      wait(!s_busy);
      sda_res   <= 1;
      sda_trans <=0;
      collect   <= 1'b0;
      if(col_data[7:1] == sl_addr)
        $display("PASS ;) :: Slave Addr = %h", col_data[7:1]);
      else
        $error("FAIL ;( :: Slave Addr = %h", col_data[7:1]);
      wait(s_busy);
      sda_res   <= 0;
      
      // Command Register Address
      $display("----------- Transmit Command Address -----------");
      @(posedge clk);
      wait(s_busy);
      collect   <= 1'b1;
      @(posedge clk);
      wait(!s_busy);
      sda_res   <= 1;
      collect   <= 1'b0;
      if(col_data == sl_cmd)
        $display("PASS ;) :: Command Pointer = %h", col_data);
      else
        $error("FAIL ;( :: Command Pointer = %h", col_data);
      slave_cmd <= col_data;
      wait(s_busy);
      sda_res   <= 0;
      
      // write Data to Command Register
      $display("------------- Transmit Command DATA ------------");
      @(posedge clk);
      wait(s_busy);
      collect   <= 1'b1;
      @(posedge clk);
      wait(!s_busy);
      sda_res   <= 1;
      collect   <= 1'b0;
      sda_trans <=0;
      if(col_data == sl_data)
        $display("PASS ;) :: Command Data = %h", col_data);
      else
        $error("FAIL ;( :: Command Data = %h", col_data);
      slave_data <= col_data;
      wait(s_done);
      sda_res  <= 0;
      wait(sda & scl);
      #(`DVSR*10)@(posedge clk);
   endtask; // write
   
   task recev(logic [6:0] sl_addr, logic [7:0] sl_cmd);   
      init    <= 1;
      sda_res <= 0;
      rd_wr   <= 0;
      wr      <= 0;
      addr    <= sl_addr;
      cmd     <= sl_cmd;
      collect <= 1'b0;
      r       <= 1'b0;
      // send slave address
      $display("------------ Transmit Slave Address ------------");
      @(posedge clk);
      init      <= 0;
      wait(s_busy);
      collect   <= 1'b1;
      @(posedge clk);
      wait(!s_busy);
      sda_res   <= 1;
      sda_trans <=0;
      collect   <= 1'b0;
      if(col_data[7:1] == sl_addr)
        $display("PASS ;) :: Slave Addr = %h", col_data[7:1]);
      else
        $error("FAIL ;( :: Slave Addr = %h", col_data[7:1]);
      wait(s_busy);
      sda_res  <= 0;
      
      // command pointer
      $display("----------- Transmit Command Address -----------");
      @(posedge clk);
      wait(s_busy);
      collect  <= 1'b1;
      @(posedge clk);
      wait(!s_busy);
      sda_res  <= 1;
      collect  <= 1'b0;
      if(col_data == sl_cmd)
        $display("PASS ;) :: Command Pointer = %h", col_data);
      else
        $error("FAIL ;( :: Command Pointer = %h", col_data);
      slave_cmd <= col_data;
      wait(s_done);
      sda_res <= 0;
      wait(sda & scl);
      #(`DVSR*4)@(posedge clk);
      
      // READ => addr, receive
      init     <= 1;
      sda_res  <= 0;
      rd_wr    <= 1;
      addr     <= sl_addr;
      cmd      <= sl_cmd;
      collect  <= 1'b0;
      $display("----------------- Receive Data -----------------");
       // send slave address
      @(posedge clk);
      init      <= 0;
      wait(s_busy);
      collect   <= 1'b1;
      @(posedge clk);
      wait(!s_busy);
      sda_res   <= 1;
      sda_trans <=0;
      collect   <= 1'b0;
      transmit  <= 1'b0;
      if(col_data[7:1] == sl_addr)
        $display("PASS ;) :: Slave Addr = %h", col_data[7:1]);
      else
        $error("FAIL ;( :: Slave Addr = %h", col_data[7:1]);
      @(posedge clk);
        
      // recev data  
      wait(s_busy);
      sda_res   <= 1;
      r         <= 1'b1;
      transmit  <= 1'b1;
      collect   <= 1'b1;
      @(posedge clk);
      wait(!s_busy);
          r        <= 1'b0;
          transmit <= 1'b0;
          collect  <= 1'b0;
          sda_res  <= 0;
          @(posedge clk);
      if(slave_cmd[1:0] == 2'b00 || slave_cmd[1:0] == 2'b11)begin
          wait(s_busy);
          transmit <= 1'b1;
          sda_res  <= 1;
          collect  <= 1'b1;
          @(posedge clk);
          wait(s_busy);
          @(posedge clk);
          wait(!s_busy);
          sda_res  <= 0;
          collect  <= 1'b0;
          wait(s_done);
            if(o_data == temp_data)
                $display("PASS ;) :: Temperature Data = %h", o_data);
            else if(o_data == default_data)
                $display("PASS ;) :: Default Data = %h", o_data);
            else
                $error("FAIL ;( :: Received up data = %h", o_data);
      end else begin
          sda_res  <= 0;
          collect  <= 1'b0;
          wait(s_done);
          if(slave_cmd[1:0] == 2'b01)
            $display("PASS ;) :: Config Data = %h", o_data[15:8]);
          else if(slave_cmd[1:0] == 2'b10)
            $display("PASS ;) :: Config Data = %h", o_data[15:8]);
          else
            $error("FAIL ;( :: Received data = %h",o_data[15:8]);
      end
      sda_res <= 0;
      wait(sda & scl);
      #(`DVSR*10)@(posedge clk);
 endtask // recev
      

always_comb begin
    case(slave_cmd)
        8'h0 : trans_data = temp_data;
        8'h1 : trans_data = {slave_data,8'h0};
        8'h2 : trans_data = {slave_data,8'h0};
        8'h3 : trans_data = default_data;
        default: trans_data = temp_data;
    endcase
end
        
// Verification
// Receive data from SDA when MASTER is transmitting   
always_ff@(posedge scl)begin
    if(collect)begin
        col_data[col_cnt] = sda;
        if(col_cnt == 0)begin
            col_cnt <= 7;
        end else begin
            col_cnt <= col_cnt - 1;
        end
    end else begin
        col_data <= 0;
        col_cnt  <= 7;
    end
end
// Transmit data on SDA for the MASTER to receiving 
always_ff@(posedge scl)begin
    if(transmit)begin
        sda_trans<= trans_data[(8*r)+trn_cnt];
        if(trn_cnt == 0)begin
            trn_cnt <= 7;
        end else begin
            trn_cnt <= trn_cnt - 1;
        end
    end else begin
        trn_cnt  <= 7;
    end
end

endinterface // i2c_intf           
