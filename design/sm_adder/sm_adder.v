/*
 Design: Sign-magnitude adder
 Designer: Kiran
 Description: Designing a simple signed magnitude adder, where the MSB of the interger value is the sign and the remaining bits are magnitude of the number.
 - When two operands have the same sign, the magnitudes are added and the sign is kept.
 - When the operands have differents signs, the smallest of the two number is subtracted from the larger one and the sign of the largest number is kept.
 */

module sm_adder #(parameter n = 8)(/*AUTOARG*/
   // Outputs
   res,
   // Inputs
   opA, opB
   );

   input [n-1:0] opA;
   input [n-1:0] opB;

   output [n-1:0]  res;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [n-1:0]		res;
   // End of automatics

   /*AUTOWIRE*/
 
   // Check for the sign
   always@(/*AUTOSENSE*/opA or opB)
     begin
	if(opA[n-1] == opB[n-1]) begin
	   res[n-1] = opA[n-1];
	   res[n-2:0] = opA[n-2:0] + opB[n-2:0];
	end else begin
	   if( opA < opB) begin
	      res[n-1] = opB[n-1];
	      res[n-2:0] = opB[n-2:0] - opA[n-2:0];
	   end else begin
	      res[n-1] = opA[n-1];
	      res[n-2:0] = opA[n-2:0] - opB[n-2:0];
	   end
	end // else: !if(opA[n-1] == opB[n-1])
     end // always@ (*)
	   
endmodule // sm_adder
