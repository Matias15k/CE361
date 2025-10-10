/*
  
  Northwestern University
  CompEng361 - Fall 2024
  Lab 2
  
  Name:
  NetID:
  
  */
  
module ExecutionUnit(
		     output [31:0] out,
		     input [31:0]  opA,
		     input [31:0]  opB,
		     input [2:0]   func,
		     input [6:0]   auxFunc);
   
   // Place your code here

   assign out = opA + opB; // We're giving you add for free. Enjoy!

endmodule // ExecutionUnit
